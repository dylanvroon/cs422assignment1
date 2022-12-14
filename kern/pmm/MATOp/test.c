#include <lib/debug.h>
#include <pmm/MATIntro/export.h>
#include "export.h"

#define PAGESIZE     4096
#define VM_USERLO    0x40000000
#define VM_USERHI    0xF0000000
#define VM_USERLO_PI (VM_USERLO / PAGESIZE)
#define VM_USERHI_PI (VM_USERHI / PAGESIZE)

int MATOp_test1()
{
    int page_index = palloc();
    if (page_index < VM_USERLO_PI || VM_USERHI_PI <= page_index) {
        dprintf("test 1.1 failed: (%d < VM_USERLO_PI || VM_USERHI_PI <= %d)\n", page_index, page_index);
        dprintf("test page index: 0x%x\n", page_index);
        pfree(page_index);
        return 1;
    }
    if (at_is_norm(page_index) != 1) {
        dprintf("test 1.2 failed: (%d != 1)\n", at_is_norm(page_index));
        dprintf("test page index: 0x%x\n", page_index);
        pfree(page_index);
        return 1;
    }
    if (at_is_allocated(page_index) != 1) {
        dprintf("test 1.3 failed: (%d != 1)\n", at_is_allocated(page_index));
        dprintf("test page index: 0x%x\n", page_index);
        pfree(page_index);
        return 1;
    }
    pfree(page_index);
    if (at_is_allocated(page_index) != 0) {
        dprintf("test 1.4 failed: (%d != 0)\n", at_is_allocated(page_index));
        dprintf("test page index: 0x%x\n", page_index);
        return 1;
    }
    dprintf("test 1 passed.\n");
    return 0;
}

/**
 * Write Your Own Test Script (optional)
 *
 * Come up with your own interesting test cases to challenge your classmates!
 * In addition to the provided simple tests, selected (correct and interesting) test functions
 * will be used in the actual grading of the lab!
 * Your test function itself will not be graded. So don't be afraid of submitting a wrong script.
 *
 * The test function should return 0 for passing the test and a non-zero code for failing the test.
 * Be extra careful to make sure that if you overwrite some of the kernel data, they are set back to
 * the original value. O.w., it may make the future test scripts to fail even if you implement all
 * the functions correctly.
 */
int MATOp_test_own()
{
    int page_indices[] = {0,0,0,0,0,0,0,0,0,0};
    for (int i = 0; i < 10; i ++) {
        page_indices[i] = palloc();
        if (page_indices[i] < VM_USERLO_PI || VM_USERHI_PI <= page_indices[i]) {
            dprintf("test 2.1 failed: (%d < VM_USERLO_PI || VM_USERHI_PI <= %d)\n", page_indices[i], page_indices[i]);
            dprintf("test page index: 0x%x\n", page_indices[i]);
            pfree(page_indices[i]);
            return 1;
        }
    }
    for (int i = 0; i < 10; i++) {
        pfree(page_indices[i]);
    }
    for (int j = 0; j < 200000; j++) {
        for (int i = 0; i < 10; i ++) {
            page_indices[i] = palloc();
            if (page_indices[i] < VM_USERLO_PI || VM_USERHI_PI <= page_indices[i]) {
                dprintf("test 2.2 failed: (%d < VM_USERLO_PI || VM_USERHI_PI <= %d)\n", page_indices[i], page_indices[i]);
                dprintf("test page index: 0x%x\n", page_indices[i]);
                pfree(page_indices[i]);
                return 1;
            }
        }
        for (int i = 0; i < 10; i++) {
            pfree(page_indices[i]);
        }
    }
    for (int i = 0; i < 10; i++) {
        if (at_is_allocated(page_indices[i]) != 0) {
            dprintf("test 2.4 failed: (%d != 0)\n", at_is_allocated(page_indices[i]));
            dprintf("test page index: 0x%x\n", page_indices[i]);
            return 1;
        }
    }
    // TODO (optional)
    dprintf("own test 2 passed.\n");
    return 0;
}

int test_MATOp()
{
    return MATOp_test1() + MATOp_test_own();
}
