#include <lib/debug.h>
#include "import.h"

#define PAGESIZE     4096
#define VM_USERLO    0x40000000
#define VM_USERHI    0xF0000000
#define VM_USERLO_PI (VM_USERLO / PAGESIZE)
#define VM_USERHI_PI (VM_USERHI / PAGESIZE)

/**
 * The initialization function for the allocation table AT.
 * It contains two major parts:
 * 1. Calculate the actual physical memory of the machine, and sets the number
 *    of physical pages (NUM_PAGES).
 * 2. Initializes the physical allocation table (AT) implemented in the MATIntro layer
 *    based on the information available in the physical memory map table.
 *    Review import.h in the current directory for the list of available
 *    getter and setter functions.
 */
void pmem_init(unsigned int mbi_addr)
{
    unsigned int nps;
    unsigned int highest_phy_address;
    unsigned int pmm_table_length;
    

    // Calls the lower layer initialization primitive.
    // The parameter mbi_addr should not be used in the further code.
    devinit(mbi_addr);

    /**
     * Calculate the total number of physical pages provided by the hardware and
     * store it into the local variable nps.
     * Hint: Think of it as the highest address in the ranges of the memory map table,
     *       divided by the page size.
     */
    pmm_table_length = get_size();
    highest_phy_address = get_mms(pmm_table_length - 1) + get_mml(pmm_table_length - 1);
    nps = highest_phy_address/PAGESIZE + ((highest_phy_address % PAGESIZE) != 0); // TODO: Do we need to do ceiling instead of just raw division? 
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.

    /**
     * Initialization of the physical allocation table (AT).
     *
     * In CertiKOS, all addresses < VM_USERLO or >= VM_USERHI are reserved by the kernel.
     * That corresponds to the physical pages from 0 to VM_USERLO_PI - 1,
     * and from VM_USERHI_PI to NUM_PAGES - 1.
     * The rest of the pages that correspond to addresses [VM_USERLO, VM_USERHI)
     * can be used freely ONLY IF the entire page falls into one of the ranges in
     * the memory map table with the permission marked as usable.
     *
     * Hint:
     * 1. You have to initialize AT for all the page indices from 0 to NPS - 1.
     * 2. For the pages that are reserved by the kernel, simply set its permission to 1.
     *    Recall that the setter at_set_perm also marks the page as unallocated.
     *    Thus, you don't have to call another function to set the allocation flag.
     * 3. For the rest of the pages, explore the memory map table to set its permission
     *    accordingly. The permission should be set to 2 only if there is a range
     *    containing the entire page that is marked as available in the memory map table.
     *    Otherwise, it should be set to 0. Note that the ranges in the memory map are
     *    not aligned by pages, so it may be possible that for some pages, only some of
     *    the addresses are in a usable range. Currently, we do not utilize partial pages,
     *    so in that case, you should consider those pages as unavailable.
     */


    // Pages: 0 to VM_USERLO_PI - 1 are reserved by the kernel, so set permissions to 1.
    unsigned int page_index = 0;
    for (;page_index < VM_USERLO_PI; page_index++) {
        at_set_perm(page_index, 1);
    }

    // [VM_USERLO, VM_USERHI) set 2 ONLY IF the entire page falls into one of the ranges in the memory map table with the permission marked as usable, else 0.
    unsigned int pmm_table_index = 0; 
    unsigned int cur_page_start;
    unsigned int cur_page_end;
    for (; page_index < VM_USERHI_PI; page_index++) {

        cur_page_start = page_index * PAGESIZE;
        cur_page_end = (page_index + 1) * PAGESIZE - 1;
        
        // Catch the table index up with the page index
        while (pmm_table_index < pmm_table_length && (get_mms(pmm_table_index) + get_mml(pmm_table_index)) < cur_page_start) { 
            pmm_table_index++;
        }  

        // Set everything to BIOS if table finished 
        if (pmm_table_index >= pmm_table_length) {
            for (; page_index < VM_USERHI_PI; page_index++) {
                at_set_perm(page_index, 0);
            }
            break; 
        }

        // Check if page contained in accessible memory segment
        unsigned int cur_table_start = get_mms(pmm_table_index);
        unsigned int cur_table_end = cur_table_start + + get_mml(pmm_table_index);
        if (cur_table_start <= cur_page_start && is_usable(pmm_table_index) && cur_table_end >= cur_page_end) {
            at_set_perm(page_index, 2);
        }
        else {
             at_set_perm(page_index, 0);
        }
    }

    // VM_USERHI_PI to NUM_PAGES - 1 are reserved by the kernel, so set permissions to 1 
    for (;page_index < nps - 1; page_index++) {
        at_set_perm(page_index, 1);
    }
}
