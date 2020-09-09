```
$ git checkout Example_9
error: The following untracked working tree files would be overwritten by checkout:
        calc_ui.pot
Please move or remove them before you can switch branches.
```
Ok. Let's delete this file - in the next example we already have it:
```
$ rm calc_ui.pot
$ git checkout Example_9
Previous HEAD position was 156bba2... L10N enabling for calc_ui
HEAD is now at b24e4a1... Fixed linking ncalc_ui
$ git diff Example_8 Example_9 | less
```
As you can see, we just made a translation into Russian of the corresponding PO file and added installation steps to the Makefile. Let's look at the PO file with Russian translation:
```
$ cat calc_ui-ru.po
```
First we have the metadata and then the pairs of translation strings: `msgid` with the source and `msgstr` with the translation. This is not a good translation strategy because, for example, some messages in one language may have different meanings in other languages in a different context. And in larger software projects like Firefox or Open/LibreOffice, other localization engines have been used in which each line from the user interface has its own unique identifier and translation for each one. And to simplify and unify the translation process, they use such complex tools as editors with support for the translation memory mechanism.

But gettext is widely used in the UNIX-like world, and that's enough for our purposes. Let's compile and install our translation now:
```
$ sudo make install
[sudo] password for liveuser: 
msgfmt -o calc_ui-ru.mo calc_ui-ru.po
install calc calc_ui /usr/local/bin
which gdialog >/dev/null 2>&1 || install gdialog /usr/local/bin
grep -q "`cat calc.services`" /etc/services || cat calc.services >> /etc/services
install calc.xinetd /etc/xinetd.d/calc
ln -sf /usr/local/bin/calc_ui /usr/local/bin/ncalc_ui
install calc_ui-ru.mo /usr/share/locale/ru/LC_MESSAGES/calc_ui.mo
```
As we can see, we compile our translation file `calc_ui-ru.po` into `calc_ui-ru.mo` and install the resulting binary localization file into the LC_MESSAGES locale directory. Let's check the result:
```
$ LANG=ru_RU.UTF-8 calc_ui
```
Great! We have a calculator in Russian now! Let's switch to English again:
```
$ LANG=en_US.UTF-8 calc_ui
```
In English again. For other languages, we still have the same interface because we didn't translate the messages for them:
```
$ LANG=zh_CN.UTF-8 calc_ui
```
And maybe it's a good time to translate our application into your favorite language...
