# MMU, Virtual Memory and shared libraries

As we remember, we have a hardware mechanism for defining a virtual set of instructions -- interrupts
["Under the Hood" -- kernel as a set of interrupt handlers](under_the_hood/interrupts.md). But we also have some machinery for memory virtualization at the hardware level -- so-called [Memory Management Unit (MMU)](https://en.wikipedia.org/wiki/Memory_management_unit).

Modern MMUs typically divide the virtual address space (the range of addresses used by the processor) into pages, each having a size which is a power of 2, usually a few kilobytes, but they may be much larger. The bottom bits of the address (the offset within a page) are left unchanged. The upper address bits are the virtual page numbers.

Most MMUs use an in-memory table of items called a "page table", containing one "page table entry" (PTE) per page, to map virtual page numbers to physical page numbers in main memory. This mapping does for processes, for dynamic libraries that are loaded by such a process. But actually, these are pages from physical memory, to which the loaded dynamic library is shared by all the processes that use it. This reduces the total amount of memory used by processes.

Sometimes the PTE denies access to a virtual page, possibly because no physical RAM has been allocated for that virtual page. In this case, the MMU signals a page failure via a CPU hardware interrupt. The operating system (OS) then handles the situation, perhaps trying to find a spare RAM frame and configure a new PTE to match it to the requested virtual address. If there is no free RAM, you may need to select an existing page (known as "victim") using some replacement algorithm and save it to disk (a process called "paging" or "swapping"). When the process scheduler tries to resume the replaced process on the CPU, pages swapped out to disk again will be reloaded from disk to memory by a page fault interrupt.

Also the MMU may generate illegal access error conditions or invalid page faults upon illegal or non-existing memory accesses, respectively, leading to segmentation fault or bus error conditions when handled by the operating system. In this case, the OS can create a core dump with a memory image of the process for further debugging and crash analysis. See our ["Under the Hood" -- Core dump](under_the_hood/core_dump.md) lecture.

