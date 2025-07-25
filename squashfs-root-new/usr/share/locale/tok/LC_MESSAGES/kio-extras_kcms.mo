��    ?        Y         p     q  
   ~     �     �     �     �     �  E   �    )  .  @  s  o  �  �  2   �  1     X   ?     �     �  <   �                =  2   J     }      �  !   �     �     �     �  )        0     D  5   `  *   �  +   �  ,   �  ,     :   G  .   �  /   �  0   �  0        C     O     [     j     �     �  6   �     �     �  )        2     8  F   H  G   �  ,   �           
  +   +  ?   W  (   �  N   �  �    >   �  /   �     *  $   6     [     u  '   |  
   �  �  �  5  �  �  �    �     �      �   ?   �   	   
!     !     #!     (!  "   6!     Y!  /   e!  
   �!     �!  )   �!     �!     �!     �!     "  !   )"  #   K"  @   o"  2   �"  3   �"  4   #  4   L#  3   �#  0   �#  1   �#  2   $  2   K$  
   ~$     �$     �$     �$     �$     �$  )   �$  !   �$  !   %     A%     \%     c%  ,   p%  -   �%     �%     �%     �%  0   �%  2   /&  !   b&  )   �&     /   !   (   5               ,                          8             
   -       .      1       4                  +   2   %             *         :       "                       #                6   )               &   0   ?          =      	       $      <      7             9          >   3       '           ;            byte  bytes  day  days  days &Enable Web search keywords &Keyword delimiter: &Name: &Use preferred keywords only - web short cut (e.g. gg): what it refers to (e.g. Google)- %1: "%2" <qt>
<p>Enter a comma separated list of hostnames or ip addresses that should be excluded from using the above proxy settings.</p>
<p>If you want to exclude all hosts for a given domain, then simply enter the domain name preceded by a dot. For example, to exclude all hostnames for <i>kde.org</i>, enter <i>.kde.org</i>. Wildcard characters such as '*' or '?' are not supported and will have no effect.</p>
<p>Additionally, you can also enter IP addresses, e.g. 127.0.0.1 and IP addresses with a subnet, e.g. 192.168.0.1/24.</p>
</qt> <qt>
Enter the URI that is used to perform a search on the search engine here.<br/>The whole text to be searched for can be specified as \{@} or \{0}.<br/>
Recommended is \{@}, since it removes all query variables (name=value) from the resulting string, whereas \{0} will be substituted with the unmodified query string.<br/>You can use \{1} ... \{n} to specify certain words from the query and \{name} to specify a value given by 'name=value' in the user query.<br/>In addition it is possible to specify multiple references (names, numbers and strings) at once (\{name1,name2,...,"string"}).<br/>The first matching value (from the left) will be used as the substitution value for the resulting URI.<br/>A quoted string can be used as the default value if nothing matches from the left of the reference list.
</qt> <qt>
Setup proxy configuration.
<p>
A proxy server is an intermediate machine that sits between your computer and the Internet and provides services such as web page caching and filtering. Caching proxy servers give you faster access to web sites you have already visited by locally storing or caching those pages; filtering proxy servers usually provide the ability to block out requests for ads, spam, or anything else you want to block.
<p>
If you are uncertain whether or not you need to use a proxy server to connect to the Internet, consult your Internet service provider's setup guide or your system administrator.
</qt> <qt><p>Use proxy settings defined on the system.</p>
<p>Some platforms offer system wide proxy configuration information and selecting this option allows you to use those settings.</p>
<p>On Mac platforms</p>
<p>On Windows platforms</p>
<p>On Unix and Linux platforms, such system proxy settings are usually defined through environment variables. The following environment variables are detected and used when present: <b>HTTP_PROXY</b>, <b>HTTPS_PROXY</b>, <b>FTP_PROXY</b>, <b>NO_PROXY</b>.</p>
</qt> @item:inlistbox No default web search keywordNone @item:inlistbox The default character setDefault @label:spinboxIf cancelled, automatically delete partially uploaded files smaller than: @title:columnKeywords @title:columnPreferred @title:column Name label from web search keyword columnName @title:windowUpdate Failed Add a new Web search keyword Auto D&etect Choose a delimiter to mark the Web search keyword. Cleanup: Colon as keyword delimiterColon Connect to the Internet directly. De&lete Default Web &search keyword: Delete files older than Delete the highlighted Web search keyword Disable Passive FTP Enable passive &mode (PASV) Enter the address for the proxy configuration script. Enter the address of the FTP proxy server. Enter the address of the HTTP proxy server. Enter the address of the HTTPS proxy server. Enter the address of the SOCKS proxy server. Enter the human-readable name of the search provider here. Enter the port number of the FTP proxy server. Enter the port number of the HTTP proxy server. Enter the port number of the HTTPS proxy server. Enter the port number of the SOCKS proxy server. Exceptions: FTP Options Global Options Insert query placeholder Keep It Limit to Manually enter proxy server configuration information. Mark &partially uploaded files Mark partially uploaded files Modify the highlighted Web search keyword Port: Search F&ilters Select the character set that will be used to encode your search query Select the character set that will be used to encode your search query. Show the &value of the environment variables Size: Space as keyword delimiterSpace Use manually specified proxy configuration: Use the specified proxy script to configure the proxy settings. Use this proxy server for a&ll protocols You have to restart the running applications for these changes to take effect. Project-Id-Version: ante-toki-pi-ilo-kde
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2024-01-15 22:34-0500
Last-Translator: Janet Blackquill <uhhadd@gmail.com>
Language-Team: C <kde-i18n-doc@kde.org>
Language: tok
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=4; plural=n == 0 ? 0 : n == 1 ? 1 : n == 2 ? 2 : 3;
X-Generator: Lokalize 22.11.70
  suli Byte wan  suli Byte luka  suli Byte mute  suli Byte mute  tenpo suno  tenpo suno  tenpo suno  tenpo suno  tenpo suno o &kepeken e nasin lili pi ilo alasa sitelen pi insa tu &nimi: &nimi: o kepeken e nimi pi wile nanpa wan taso - %1: "%2" <qt>
<p>o sitelen e kulupu (sama ni: "ijo #1,ijo #2,ijo #3") pi nimi linluwi. ilo pi nasin linluwi li lawa ala e ilo pi nimi linluwi pi pana sina.</p>
<p>sina wile weka e lawa tawa nimi ale lon nimi suli la, o sitelen e sike pini (.) lon open nimi linluwi sama ni: <i>.kde.org</i> li weka e lawa tawa ijo ale pi pini <i>kde.org</i> sama ni: apps.kde.org en invent.kde.org. sike * en nimi ? li pali ala.</p>
<p>sina ken sitelen e nanpa linluwi kin. sama ni: 127.0.0.1 en 192.168.0.1/24</p>
</qt> <qt>
o sitelen e nimi URL pi ilo alasa lon poki ni.<br/>
sitelen \{@} en sitelen \{0} li jo e sitelen alasa.<br/>
o kepeken e \{@} tan ni: ona li weka e nimi sona (nimi=ijo) tan nimi alasa.
\{0} li weka ala e nimi sona.<br/>
sina ken kepeken \{1} ... \{nanpa} tawa sitelen e nimi pi nanpa ona.
sina ken kepeken \{nimi} tawa sitelen e nimi pi nimi sona (nimi=ijo) sama.<br/>
kin la, \{} li ken jo e nimi mute sama ni: \{nimi1, nimi2, ... "nimi"}.<br/>
ijo lon nanpa wan li kepeken tawa nimi URL.<br/>
ijo ale li lon ala la sitelen lon poki ("") li ken kepeken.
</qt> <qt>
o toki e wile sina pi nasin linluwi.
<p>
ilo pi nasin linluwi li lon meso ilo sina en ilo linluwi ante ale. ona li ken pana e ken pi awen sona e ken pi weka ike.
sina lukin mute e lipu wan la ilo pi nasin linluwi pi awen sona li lili e tenpo alasa ona.
ilo pi nasin linluwi pi weka ike li ken weka e sitelen mani e sitelen jaki e ijo pi wile sina.
</p>
sina sona ala e wile ilo linluwi la, o toki e jan ilo e kulupu ilo sina.
</qt> <qt>
<p>ni li kepeken e lawa ilo suli</p>
<p>ilo suli li ken jo e lawa tawa ilo pi nasin linluwi</p>
<p>lon ilo Mac</p>
<p>lon ilo Windows</p>
<p>ilo Unix en ilo Linux la, ilo suli li kepeken e nimi sona <b>HTTP_PROXY</b>, <b>HTTPS_PROXY</b>, <b>FTP_PROXY</b>, <b>NO_PROXY</b>.</p>
</qt> ala ijo tan jan pana pi ilo sina pana lipu li pini lon insa pana la, o weka e lipu meso pi lili: nimi suli wile nanpa wan nimi sin li pakala o lon e nimi lili pi ilo alasa sin alasa &sona o pana e nimi pi insa tu tawa nimi pi ilo alasa weka jaki: sike tu (:) o toki tawa linluwi kepeken ala ijo ante. o &weka nimi &alasa nanpa wan: o weka e lipu pi sin ala o weka e nimi pi kule ante o kepeken ala ilo FTP pi lawa ala o kepeken &nasin pi lawa ala (PASV) o sitelen e nimi nasin tawa sitelen ilo pi ilo pi nasin linluwi. o pana e nimi linluwi pi ilo pi nasin linluwi FTP. o pana e nimi linluwi pi ilo pi nasin linluwi HTTP. o pana e nimi linluwi pi ilo pi nasin linluwi HTTPS. o pana e nimi linluwi pi ilo pi nasin linluwi SOCKS. o sitelen e nimi tawa jan pi ilo alasa lon poki ni. o pana e nanpa lupa pi ilo pi nasin linluwi FTP. o pana e nanpa lupa pi ilo pi nasin linluwi HTTP. o pana e nanpa lupa pi ilo pi nasin linluwi HTTPS. o pana e nanpa lupa pi ilo pi nasin linluwi SOCKS. lawa ante: lawa FTP lawa pi ijo ale o sitelen e nimi poki o awen e ona o awen e lili o sitelen e lawa pi ilo pi nasin linluwi. o sitelen e lipu pi pana ale ala. o sitelen e lipu pi pana ale ala. o ante e nimi pi kule ante nanpa: &nasin alasa o pana e nasin sitelen tawa wile alasa sina. o pana e nasin sitelen tawa wile alasa sina.. o sitelen e &insa pi sona ma suli: sitelen ala ( ) o kepeken e lawa pana tawa ilo pi nasin linluwi: o kepeken e sitelen ilo tawa ilo pi nasin linluwi. o kepeken e ilo ni tawa toki &ale sina sin e ilo la ante sina li kama pali. 