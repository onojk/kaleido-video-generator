��    :      �  O   �      �     �       E     �   Z      �   5  .  �    �  �   �  �   �  �   �  �   �  �   �  s  �  �  6  �   -  1        A     Y     u  W   �      �  !   �          %     9  Z   U  5   �  *   �  +     ,   =  ,   j  :   �  .   �  /     0   1  0   b     �     �     �     �  6   �          "     @     F  F   V  G   �  ,   �             +   9  ?   e  (   �  �   �  l   �  N   �  |  L     �     �     �  �   �  -  �   l   �"  5  K#    �&  �   �'  �   v(  �   i)  �   Z*  �   M+  W  ?,  �  �.  �   N0     1     1     "1     71  X   H1     �1  $   �1     �1     �1     �1  p   2  9   }2  *   �2  +   �2  ,   3  ,   ;3  :   h3  .   �3  /   �3  0   4  0   34  	   d4     n4     }4     �4  "   �4  %   �4  %   �4     5     5  Q   %5  R   w5  +   �5     �5  	   �5  +   6  7   46  /   l6  �   �6  �   c7  ]   �7                           0       $      2   5   ,   %                    4           +             .   &   "   )      -      /           
   7                                #   1                               	   (   :   8   9       6          '      *               3   !               &Keyword delimiter: &Name: - web short cut (e.g. gg): what it refers to (e.g. Google)- %1: "%2" <p>Marks partially uploaded FTP files.</p><p>When this option is enabled, partially uploaded files will have a ".part" extension. This extension will be removed once the transfer is complete.</p> <qt>
<p>Enter a comma separated list of hostnames or ip addresses that should be excluded from using the above proxy settings.</p>
<p>If you want to exclude all hosts for a given domain, then simply enter the domain name preceded by a dot. For example, to exclude all hostnames for <i>kde.org</i>, enter <i>.kde.org</i>. Wildcard characters such as '*' or '?' are not supported and will have no effect.</p>
<p>Additionally, you can also enter IP addresses, e.g. 127.0.0.1 and IP addresses with a subnet, e.g. 192.168.0.1/24.</p>
</qt> <qt>
Check this box if you want the above proxy settings to apply only to the addresses listed in the <i>Exceptions</i> list.</qt> <qt>
Enter the URI that is used to perform a search on the search engine here.<br/>The whole text to be searched for can be specified as \{@} or \{0}.<br/>
Recommended is \{@}, since it removes all query variables (name=value) from the resulting string, whereas \{0} will be substituted with the unmodified query string.<br/>You can use \{1} ... \{n} to specify certain words from the query and \{name} to specify a value given by 'name=value' in the user query.<br/>In addition it is possible to specify multiple references (names, numbers and strings) at once (\{name1,name2,...,"string"}).<br/>The first matching value (from the left) will be used as the substitution value for the resulting URI.<br/>A quoted string can be used as the default value if nothing matches from the left of the reference list.
</qt> <qt>
Enter the environment variable, e.g. <b>NO_PROXY</b>, used to store the addresses of sites for which the proxy server should not be used.<p>
Alternatively, you can click on the <b>"Auto Detect"</b> button to attempt an automatic discovery of this variable.
</qt> <qt>
Enter the name of the environment variable, e.g. <b>FTP_PROXY</b>, used to store the address of the FTP proxy server.<p>
Alternatively, you can click on the <b>"Auto Detect"</b> button to attempt an automatic discovery of this variable.</p>
</qt> <qt>
Enter the name of the environment variable, e.g. <b>HTTPS_PROXY</b>, used to store the address of the HTTPS proxy server.<p>
Alternatively, you can click on the <b>"Auto Detect"</b> button to attempt an automatic discovery of this variable.</p>
</qt> <qt>
Enter the name of the environment variable, e.g. <b>HTTP_PROXY</b>, used to store the address of the HTTP proxy server.<p>
Alternatively, you can click on the <b>"Auto Detect"</b> button to attempt automatic discovery of this variable.</p>
</qt> <qt>
Enter the name of the environment variable, e.g. <b>SOCKS_PROXY</b>, used to store the address of the SOCKS proxy server.<p>
Alternatively, you can click on the <b>"Auto Detect"</b> button to attempt an automatic discovery of this variable.</p>
</qt> <qt>
Select the search engine to use for input boxes that provide automatic lookup services when you type in normal words and phrases instead of a URL. To disable this feature select <b>None</b> from the list.
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
</qt> <qt>Attempt automatic discovery of the environment variables used for setting system wide proxy information.<p> This feature works by searching for commonly used variable names such as HTTP_PROXY, FTP_PROXY and NO_PROXY.</qt> @item:inlistbox The default character setDefault @title:columnPreferred @title:windowUpdate Failed Auto D&etect Choose the delimiter that separates the keyword from the phrase or word to be searched. Colon as keyword delimiterColon Connect to the Internet directly. De&lete Disable Passive FTP Enable passive &mode (PASV) Enables FTP's "passive" mode. This is required to allow FTP to work from behind firewalls. Enter the address for the proxy configuration script. Enter the address of the FTP proxy server. Enter the address of the HTTP proxy server. Enter the address of the HTTPS proxy server. Enter the address of the SOCKS proxy server. Enter the human-readable name of the search provider here. Enter the port number of the FTP proxy server. Enter the port number of the HTTP proxy server. Enter the port number of the HTTPS proxy server. Enter the port number of the SOCKS proxy server. Exceptions: FTP Options Insert query placeholder Keep It Manually enter proxy server configuration information. Mark &partially uploaded files Mark partially uploaded files Port: Search F&ilters Select the character set that will be used to encode your search query Select the character set that will be used to encode your search query. Show the &value of the environment variables Size: Space as keyword delimiterSpace Use manually specified proxy configuration: Use the specified proxy script to configure the proxy settings. Use this proxy server for a&ll protocols When FTP connections are passive the client connects to the server, instead of the other way round, so firewalls do not block the connection; old FTP servers may not support Passive FTP though. While a file is being uploaded its extension is ".part". When fully uploaded it is renamed to its real name. You have to restart the running applications for these changes to take effect. Project-Id-Version: kcmkio
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2014-02-25 01:34+0100
Last-Translator: Sönke Dibbern <s_dibbern@web.de>
Language-Team: Low Saxon <kde-i18n-nds@kde.org>
Language: nds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Lokalize 1.5
Plural-Forms: nplurals=2; plural=n != 1;
 &Afkörten-Trennteken: &Naam: - %1: „%2“ <p>Markeert deelwies hoochlaadte FTP-Dateien.</p><p>Wenn anmaakt, kriegt deelwies hoochlaadte Dateien de Dateiennen ".part". De Ennen warrt wegdaan, wenn de Överdregen komplett is.</p> <qt>
<p>Giff en mit Kommas scheedt List mit Reeknernaams oder IP-Adressen in, för de Du de baven fastleggt Instellen nich bruken wullt.</p>
<p>Wullt Du all Reekners binnen en angeven Domään utsluten, giff eenfach den Domäännaam mit en vöranstellt Punkt in. Wullt Du a.B. all Reeknernaams för <i>kde.org</i> utsluten, giff <i>.kde.org</i> in. Platzhollers, as a.B. '*' oder '?' warrt nich ünnerstütt un hebbt keen Utwarken.</p>
<p>Bito laat sik ok noch IP-Adressen ingeven, a.B.. 127.0.0.1 un IP-Adressen mit Deelnett, a.B. 192.168.0.1/24.</p>
</qt> <qt>
Maak dit an, wenn Du de Instellen bloots för de Adressen in de <i>Utnahmen</i>-List bruken wullt.</qt> <qt>
Giff hier de Adress (URI) in, över de mit de Söökmaschien söcht warrt.<br/>Du kannst den helen Sööktext as \{@} oder \{0} angeven.<br/>
Anraadt is \{@}, dat treckt de Anfraagvariabeln (Naam=Weert) ut de rutkamen Tekenkeed rut; bi \{0} warrt de Sööktext ahn Ännern insett.<br/>Du kannst \{1} ... \{n} bruken, wenn Du enkelte Wöör ut den Sööktext angeven wullt, för \{Naam} warrt de Weert inföögt, de mit „Naam=Weert“ binnen den Sööktext angeven is.<br/>Wenn Du mehr as een Weert (Naams, Tallen, Tekenkeden) op eenmaal angeven wullt, kannst Du dit bruken: \{Naam1,Naam2,...,"Tekenkeed"}.<br/>De eerste passen Weert (vun links) warrt as Utwessel-Weert för de Resultaat-Adress bruukt.<br/>En Tekenkeed in Goosfööt kann as Standardweert bruukt warrn, wenn sik keen passen Weert finnen lett.
</qt> <qt>
Giff den Naam vun de Ümgevenvariable in, de de Adressen bargt, för de keen Proxyserver bruukt warrn schall, a.B. <b>NO_PROXY</b>.<p>
Du kannst ok op den Knoop <b>"Autom. opdecken"</b> klicken, wenn Du de Variable automaatsch söken laten wullt.</p>
</qt> <qt>
Giff den Naam vun de Ümgevenvariable in, de de Adress vun den FTP-Proxyserver bargt, a.B. <b>FTP_PROXY</b>.<p>
Du kannst ok op den Knoop <b>"Autom. opdecken"</b> klicken, wenn Du de Variable automaatsch söken laten wullt.</p>
</qt> <qt>
Giff den Naam vun de Ümgevenvariable in, de de Adress vun den HTTPS-Proxyserver bargt, a.B. <b>HTTPS_PROXY</b>.<p>
Du kannst ok op den Knoop <b>"Autom. opdecken"</b> klicken, wenn Du de Variable automaatsch söken laten wullt.</p>
</qt> <qt>
Giff den Naam vun de Ümgevenvariable in, de de Adress vun den HTTP-Proxyserver bargt, a.B. <b>HTTP_PROXY</b>.<p>
Du kannst ok op den Knoop <b>"Autom. opdecken"</b> klicken, wenn Du de Variable automaatsch söken laten wullt.</p>
</qt> <qt>
Giff den Naam vun de Ümgevenvariable in, de de Adress vun den SOCKS-Proxyserver bargt, a.B. <b>SOCKS_PROXY</b>.<p>
Du kannst ok op den Knoop <b>"Autom. opdecken"</b> klicken, wenn Du de Variable automaatsch söken laten wullt.</p>
</qt> <qt>
Hier kannst Du de Söökmaschien fastleggen, de Du bruken wullt, wenn Du normale Wöör un keen Adress in Ingaav-Feller ingiffst, de automaatsch söken köönt. Wenn Du disse Funkschoon utmaken wullt, bruuk <b>Keen</b> op de List.
</qt> <qt>
Proxy inrichten
<p>
En Proxyserver is en Programm oder helen Reekner, de twischen Di un dat Internet sitt. He spiekert Nettsieden twischen un / oder filter se.</p> <p>Wenn de Proxy Nettsieden twischenspiekert, geiht dat Opropen vun Sieden gauer, de al maal opropen wöörn; wenn he filtert, kann he dat Laden vun Warven un Spam blockeren, oder wat Du ok sünst noch utfiltern wullt.</p>
<p>Wenn Du nich seker weetst, wat Du en Proxyserver bruken muttst, wenn Du Di an't Internet tokoppeln wullt, kiek binnen de Inricht-Anwiesen vun Dien Internet-Anbeder oder fraag Dien Systeempleger.</p>
</qt> <qt><p>Op't Systeem fastleggt Proxy-Instellen bruken.</p>
<p>Op en Reeg vun Reekners laat sik de Systeeminstellen för Proxies bruken.</p>
<p>Op Mac-Reekners</p>
<p>Op Windows-Reekners</p>
<p>Op Unix- un Linux-Reekners warrt de Proxy-Instellen tomehrst as Ümgevenvariabeln fastleggt. Sünd disse Ümgevenvariabeln vörhannen, warrt se opdeckt un bruukt: <b>HTTP_PROXY</b>, <b>HTTPS_PROXY</b>, <b>FTP_PROXY</b>, <b>NO_PROXY</b>.</p>
</qt> <qt>Versöcht, de Variabeln för Systeem-Proxyinformatschonen automaatsch to finnen.<p> Disse Funkschoon söcht na faken bruukte Variabelnnaams as HTTP_PROXY, FTP_PROXY un NO_PROXY.</p></qt> Standard vörtrocken Opfrischen fehlslaan Autom. &opdecken Hier kannst Du dat Teken fastleggen, dat de Afkörten vun den Sööktext aftrennen deit. Dubbelpunkt Direktemang an't Internet tokoppeln. W&egdoon Passiv FTP utmaken Passivbedrief (PASV) an&maken Maakt de "passive" Bedriefoort för FTP an. Dat deit noot, wenn FTP vun achter en Nettdiek funkscheneren schall. Giff de Adress vun dat Instellenskript för den Proxy in. Giff de Adress vun den FTP-Proxyserver in. Giff de Adress vun den HTTP-Proxyserver in. Giff de Adress vun den HTTPS-Proxyserver in. Giff de Adress vun den SOCKS-Proxyserver in. Giff hier bitte den normalen Naam vun den Söökdeenst in. Giff de Portnummer vun den FTP-Proxyserver in. Giff de Portnummer vun den HTTP-Proxyserver in. Giff de Portnummer vun den HTTPS-Proxyserver in. Giff de Portnummer vun den SOCKS-Proxyserver in. Utnahmen: FTP-Optschonen Anfraag-Platzholler infögen Wohren Den Proxyserver vun Hand instellen &Deelwies hoochlaadt Dateien markeren Deelwies hoochlaadte Dateien markeren Port: Söök&filtern Hier kannst Du den Tekensett fastleggen, mit den Dien Söökanfraag kodeert warrt Hier kannst Du den Tekensett fastleggen, mit den Dien Söökanfraag kodeert warrt. Wiest de Weerten vun de Ümgeven-&Variabeln Grött: Freeteken De vun Hand angeven Proxy-Instellen bruken: Dat angeven Proxy-Skript för de Proxy-Instellen bruken Dissen Proxyserver för a&ll Protokollen bruken Bi passive FTP-Verbinnen maakt de Client de Verbinnen, nich de Server, wat anners normaal is. Nettdieken blockeert disse Verbinnen nich, man öller FTP-Servers ünnerstütt passiv FTP nich jümmers. Wenn en Datei hoochlaadt warrt, is ehr Ennen toeerst maal ".part". Wenn de Överdregen fardig is, warrt se na ehren richtigen Naam ümnöömt. Du muttst de Programmen nieg starten, de al löppt, anners warrt de Ännern nich övernahmen. 