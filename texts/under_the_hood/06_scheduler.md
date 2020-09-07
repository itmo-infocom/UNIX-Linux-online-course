To understand the relationship between priority and nice, we must turn to the UNIX process scheduler. The main task of the scheduler is to regulate the access of processes to the main computing resource -- the processor or processors in multi-processor system. This is done by providing a so-called "time quantum" to the process for the time the processor is using. And then by the timer interrupt handler this process is popped after the end of the time slice and is replaced by the next process from the LIFO queue.

Priorities are just such LIFO queues and processes from higher priority queues use the processor more often. But from time to time, some processes go into a "sleep" state, for example, to wait for I/O. And when they wake up, it's wise to move them to a higher priority queue for fairer compute resources allocation. The scheduler does this work and for this reason the priority changes dynamically. We can simply recommend relative prioritization to the scheduler with the `nice` command.

But the `nice` command only refers to CPU usage. If we need to prioritize I/O access, we need to use the `ionice` utility:
```
man ionice
```
As we can see, this command maintains a real-time scheduling class. First of all, the RT system does not mean fast response, it means guaranteed response within a given response time. Some UNIX and Linux systems support this scheduling class for the CPU as well. In most cases, they use a pre-emptive scheduling algorithm for this.
