Now let's try to localize our program.
```
$ git checkout Example_8
```
What is it "localize"? The locale is the primary mechanism for supporting the native languages in UNIX-like systems, and we have a few strange abbreviations that describe it: I18N, L10N, and even M17N. What does this mean? This means that English does not like long words, but the terminology associated with supporting native languages is too many letters. Such as -- Multilingualization for application software consisting of 17 letters between "M" and "N" and abbreviated to M17N. M17N is performed in 2 stages:
* Internationalization (18 letters between "I" and "N" -- I18N): To make a software potentially handle multiple locales.
* Localization (10 letters between "L" and "N" -- L10N): To make a software handle an specific locale.

OK. Let's take a look at our current locale settings:
```
$ locale
...
```
As we can see, there are lot of environment variables associated with this:
* LANG and LC_ALL -- General language setting. These settings can be separated to:
* LC_CTYPE -- Controls the behavior of character handling functions.
* LC_TIME -- Specifies date and time formats, including month names, days of the week, and common full and abbreviated representations.
* LC_MONETARY -- Specifies monetary formats, including the currency symbol for the locale, thousands separator, sign position, the number of fractional digits, and so forth.
* LC_NUMERIC -- Specifies the decimal delimiter (or radix character), the thousands separator, and the grouping.
* LC_COLLATE -- Specifies a collation order and regular expression definition for the locale.
* LC_MESSAGES -- Specifies the language in which the localized messages are written, and affirmative and negative responses of the locale (yes and no strings and expressions).
* LO_LTYPE -- Specifies the layout engine that provides information about language rendering. Language rendering (or text rendering) depends on the shape and direction attributes of a script.

In the C programming language, the locale name C “specifies the minimal environment for C translation” (C99 §7.11.1.1; the principle has been the same since at least the 1980s). As most operating systems are written in C, especially the Unix-inspired ones where locales are set through the LANG and LC_xxx environment variables, C ends up being the name of a “safe” locale everywhere

On POSIX platforms such as Unix, Linux and others, locale identifiers are defined by ISO standard and consists from: `[language[_territory][.codeset][@modifier]]`. For example, Australian English dialect using the UTF-8 encoding is en_AU.UTF-8.

As we can see, our application already has l10n. 
```
$ LANG=C calc_ui
$ LANG=en_US.UTF-8 calc_ui
```
As we can see, our application looks the same in base C and American English locales. In Russian we see the Russian title and buttons:
```
$ LANG=ru_RU.UTF-8 calc_ui
```
In Continental Simplified and Traditional Taiwanese Chinese, we can see different hieroglyphs sets on the title:
```
$ LANG=zh_CN.UTF-8 calc_ui
$ LANG=zh_TW.UTF-8 calc_ui 
```
And for the Arabic language, the title is written from right to left:
```
$ LANG=ar_SY.UTF-8 calc_ui
```
Looks good, but this is just a basic localization of the `zenity` utility used by `gdialog`. We need to translate our text strings in the program. And for that we can use the standard `gettext` machinery that was first implemented by Sun Microsystems in 1993. To work with this, we need a `gettext` utilities set:
```
# yum install gettext
# apt install gettext
```
We have a utility `gettext` that translates the text messages passed to it as arguments according to the settings of the locale's environment variables:
```
$ man gettext
```
As we can see, for this we just need to add a call to the `gettext` utility in all places where we used a text string as a parameter to` gettext`, and insert the result of execution into command lines by quoting the command with "back apostrophes":
```
$ git diff Example_7 Example_8
```
And now we can fetch the gettext strings from the source using the xgettext utility:
```
$ make calc_ui.pot
xgettext -o calc_ui.pot -L Shell calc_ui
```
We got the portable object template file `calc_ui.pot` that we will use as a basis for translation:
```
$ cat calc_ui.pot
...
```
For exmaple to Russian language:
```
$ msginit --locale=ru --input=calc_ui.pot
...
$ cat ru.po
```

