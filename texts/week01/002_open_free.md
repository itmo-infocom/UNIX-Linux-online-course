# Open and Free

Initially, when computer R&D projects were mostly just university research, they were open source and free of charge as a common scientific research result. In addition, scientists were very interested in widespread dissemination of this result, because their reputation directly depended on the prominence of their scientific work.

Commercialization has changed this world to a closed and paid model. Not completely closed, because standardization is very important for government agencies and corporate consumers to protect investments and prevent vendor locking. As a consequence, many open standards have been created by committees and organizations: POSIX, ANSI, ISO.

And openness was a serious weapon in business competition. For example, some well-known companies. including Bull, DEC, IBM, HP, Hitachi, Philips, Siemens and others, created the Open Software Foundation (OSF) to fight SUN and AT&T during the so-called "Unix wars". The POSIX subsystem (which was actually just a description of UNIX-like systems standards) was included in Microsoft Windows NT because in the 1980s the US federal government required compatibility with this open standard for government contracts.

This openness is very important because we get more compatible systems from different vendors, ideally without undocumented features. As a result, we have a computing infrastructure with higher efficiency and lower cost of ownership.

But for some people, especially in the scientific world, this is not enough. And in 1985, Richard Stallman from MIT published the GNU Manifesto where he announced the GNU Project. The main goal of this project was to create a UNIX-like OS with a full set of UNIX utilities from completely free software. The Free Software Foundation (FSF) was formed to support these activities.

But what is this freedom in the computer world and how is it different from openness? This difference is most accurately described in licenses. In the proprietary world, the most widely used are so-called copyright licenses, which usually restrict certain user rights. Even with legal access to the source code, the copyright holder can harass the consumer, as we saw in the USL versus BSD or SCO versus IBM lawsuits.
https://www.gnu.org/philosophy/free-software-for-freedom.en.html

In contrast, the free software world uses copyleft licenses. The most famous permissive licenses for free software were published in the late 1980s. Two of them, named BSD and MIT - the educational institutions in which they were created - look almost the same and give us the following basic rights:
* The freedom to run the program as you wish, for any purpose (freedom 0).
* The freedom to study how the program works, and change it so it does your computing as you wish (freedom 1). Access to the source code is a precondition for this.
* The freedom to redistribute copies so you can help others (freedom 2).
* The freedom to distribute copies of your modified versions to others (freedom 3). By doing this you can give the whole community a chance to benefit from your changes. Access to the source code is a precondition for this.

The most famous projects released under these licenses are BSD Unix and the MIT X-Window graphics system. Such licenses do not restrict the use of closed derivative projects and their proprietarization. To avoid this, the GNU General Public License (GNU GPL or GPL) was developed. One important limitation added to the fundamental freedoms of this license (run, learn, share and modify software) is the limitation for closing. Any derivative work must be distributed under the same or equivalent license terms.

And the main difference between open-specification software and truly free software is that we actually have a de facto standard, not a de jure standard. In free and open source software, we have working reference implementations that can be used as a basis for future development and cross-testing.

It's interesting, but this license does not completely restrict the creation of proprietary closed applications using GPL licensed software. For example, the OS kernel or shared libraries, simply because they are not included directly in the proprietary application code.

We now have many free and open source licenses approved by the Open Source Initiative: https://opensource.org/licenses

Another challenge for the free and open world is patent lawsuits. For example, in 2007, Microsoft threatened to sue Linux companies like Red Hat over patent violations. To solve this problem GPLv3 license has been created, along with some activities such as the Open Invention Network (OIN), which have a defensive patent pool and community of patent non-aggression which enables freedom of action in Linux.
