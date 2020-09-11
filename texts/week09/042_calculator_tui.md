OK -- the next example
```
$ git checkout Example_4
HEAD is now at d7f58c6... Shell spec. symbols escaping and input formatting for 'expr'.
```
It seems strange - the commit and comment are similar to the previous example. Let's check diff:
```
$ git diff Example_3 Example_4
$
```
Oh yeah - I was wrong, I placed the tag wrong - until the real changes! This is actually a good reason to take a deeper look into our repository to fix this. First, let's move on to the next example:
```
$ git checkout Example_5
Previous HEAD position was d7f58c6... Shell spec. symbols escaping and input formatting for 'expr'.
HEAD is now at f266a24... GUI
```
Ok - seems differ. Now let's look to log:
```
$ git log
commit f266a24128b1e363eddc073682aac89dd33a86a8
...
    GUI
...
commit d6453c0c41548a55e3249ea8c3b788c71cb76f7e
...
    Text UI.
...
commit d7f58c65c3e25269977538fdde0ac13d733fbf92
...
```
We see another commit between the previously discussed commit and the GUI commit - the text interface. Let's switch to it:
```
$ git checkout d6453c0c41548a55e3249ea8c3b788c71cb76f7e
Previous HEAD position was f266a24... GUI
HEAD is now at d6453c0... Text UI.
```
And what about diff?
```
$ git diff Example_3 d6453c0c41548a55e3249ea8c3b788c71cb76f7  
```
OK - changed README, Makefile and added new file:
```
$ ls
Makefile  README.md  calc  calc_ui
```
The new `calc_ui` script is the user interface for our simple command line calculator. Let's take a look inside:
```
$ cat calc_ui 
...
```
First, we see setting environment variables for temporary files. Then we define an `end` function in which we delete the temporary files and exit the program. The main action in the program is an infinite loop, in which we just call a `dialog` program and then work with the results it returns. What is it `dialog`? To understand what it is, you first need to install:
```
$ sudo yum insatll dialog
```
In Ubuntu, we have to install this program as follows:
```
$ sudo apt install dialog
```
Now we just execute `dialog`:
```
$ dialog
```
We see a lengthy help that shows us which parameters we should use to create various interface forms. For example:
```
$ dialog --yesno "To be or not to be?" 5 25
```
Make your choice and see the program exit code:
```
$ echo $?
```
You will see zero if you choose 'yes' and non-zero if 'no'. As we understand it, this is a one-shot program that shows us a uniform interface form and returns some result that we can use in our script. In our UI we use the --inputbox form and redirect the standard error from it to a temporary FILE1.

What does standard error have to do with our command? Hopefully we didn't expect any errors, just a line with our expression? Yes, but the standard output of the dialog program is already in use for drawing the UI form. As far as we understand, to draw such pretty forms, a bunch of ESC sequences for your terminal type are sent to standard output. These sequences, generated by the ncurses library, are retrieved from a terminal type database according to the TTY environment variable.

Thus, if the dialog form ended with an error exit code, it means that we clicked the "Cancel" button and then calling the "end" function. If we clicked OK, we perform the following operation - we send our input to our good old `calc` script and redirect the output and error output to separate files. And then show a dialog form with the result if the script completed successfully, and an error form if we received an error.

So it looks good. And this is an example of the KISS design principle -- we developed a simple script and just wrapped it with another simple script that implements the UI. But for the final preparation of our application for work, we need to install our `calc` script to the directory from the PATH environment variable. And for this, we added a corresponding rule to the Makefile:
```
$ cat Makefile
$ sudo make install
[sudo] password for liveuser: 
install calc calc_ui /usr/local/bin
```
Now let's play with our user friendly calculator:
```
$ calc_ui
```
Great!

