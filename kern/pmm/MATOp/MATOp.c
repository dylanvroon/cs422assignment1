#include <lib/debug.h>
#include "import.h"

#define PAGESIZE     4096
#define VM_USERLO    0x40000000
#define VM_USERHI    0xF0000000
#define VM_USERLO_PI (VM_USERLO / PAGESIZE)
#define VM_USERHI_PI (VM_USERHI / PAGESIZE)
#define CACHE_LEN 5

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
int cache[] = {-1,-1,-1,-1,-1};
unsigned int palloc()
{
    // Check cache
    for (unsigned int i = 0; i < CACHE_LEN; i++) {
        if (cache[i] != -1) {
            unsigned int cache_hit = cache[i];
            cache[i] = -1;
            return cache_hit;
        }
    }

    // Start linear scan from previous scan end
    for (unsigned int pi = prev_pi; pi < VM_USERHI_PI; pi++) {
        if (at_is_allocated(pi) == 0 && at_is_norm(pi) == 1) {
            at_set_allocated(pi, 1);
            prev_pi = pi;
            return pi;
        }
    }

    // If all else fails, redo scan from beginning 
    for (unsigned int pi = VM_USERLO_PI; pi < prev_pi; pi++) {
        if (at_is_allocated(pi) == 0 && at_is_norm(pi) == 1) {
            at_set_allocated(pi, 1);
            prev_pi = pi;
            return pi;
        }
    }

    prev_pi = VM_USERLO_PI; // Save index ended scanning at 

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
    // Add to cache 
    for (unsigned int i = 0; i < CACHE_LEN; i++) {
        if (cache[i] == -1) {
            cache[i] = pfree_index;
        }
    }
    at_set_allocated(pfree_index, 0);
}
