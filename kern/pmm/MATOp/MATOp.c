#include <lib/debug.h>
#include "import.h"

#define PAGESIZE     4096
#define VM_USERLO    0x40000000
#define VM_USERHI    0xF0000000
#define VM_USERLO_PI (VM_USERLO / PAGESIZE)
#define VM_USERHI_PI (VM_USERHI / PAGESIZE)

/**
 * Allocate a physical page.
 *
 * 1. First, implement a naive page allocator that scans the allocation table (AT)
 *    using the functions defined in import.h to find the first unallocated page
 *    with normal permissions.
 *    (Q: Do you have to scan the allocation table from index 0? Recall how you have
 *    initialized the table in pmem_init.)
 *    Then mark the page as allocated in the allocation table and return the page
 *    index of the page found. In the case when there is no available page found,
 *    return 0.
 * 2. Optimize the code using memoization so that you do not have to
 *    scan the allocation table from scratch every time.
 */

unsigned int prev_pi = VM_USERLO_PI;
unsigned int palloc()
{
    /* 
    Naive:
    - Iterate from [VM_USERLO, VM_USERHI) until find first free one
    - Set allocation
    - Return index
    

    Optimized:
    - Store last index got to when scanning? Then when at end go back to beginning. Or store like data structure of free ones?


    */
    for (unsigned int pi = prev_pi; pi < VM_USERHI_PI; pi++) {
        if (at_is_allocated(pi) == 0) {
            at_set_allocated(pi, 1);
            prev_pi = pi;
            return pi;
        }
    }
    for (unsigned int pi = VM_USERLO_PI; pi < prev_pi; pi++) {
        if (at_is_allocated(pi) == 0) {
            at_set_allocated(pi, 1);
            prev_pi = pi;
            return pi;
        }
    }
    prev_pi = VM_USERLO_PI;

    return 0;
}

/**
 * Free a physical page.
 *
 * This function marks the page with given index as unallocated
 * in the allocation table.
 *
 * Hint: Simple.
 */
void pfree(unsigned int pfree_index)
{
    // TODO
    at_set_allocated(pfree_index, 0);
}
