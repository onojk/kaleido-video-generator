��    G      T  a   �        
             "     6  E   =  �   �  �   G    -  �   D
  .  �
    �  �     �   �  �   �  �   �  �   �  s  �  �  E  �   <      �   1  �   �  y   ^  g   �  �   @  1        F     ]     u     �  W   �     �      �  !         B     J     b     v  Z   �  5   �  *   #  +   N  ,   z  ,   �  :   �  .      /   >   0   n   0   �      �      �      �      �      �   6   !     ?!     ^!     |!     �!  F   �!  G   �!  ,   !"     N"      T"  +   u"  ?   �"  (   �"  �   
#  l   �#  N   9$  �  �$     =&     [&     c&     ~&  
   �&  �   �&  �   ['  X  >(  S   �*  r  �*  @  ^.    �/    �0    �1    �2  �   �3    �4  6  �7  �   �9  (  �:  �   %<  �   �<  h   <=  i   �=  �   >  	   �>     �>     �>     �>     ?  X   ?  
   t?  
   ?  "   �?     �?     �?     �?  #   �?  X   @  B   h@  +   �@  ,   �@  -   A  -   2A  6   `A  +   �A  ,   �A  -   �A  -   B  	   LB     VB     dB     zB     �B  H   �B  &   �B  %   �B  
   %C     0C  :   CC  C   ~C  &   �C     �C     �C  E   �C  N   =D  8   �D  �   �D  �   �E  R   F         A   &              '              ?      "      G   .             %   D   =      @           /   #       )                             9          2       3   E      4   *          !   :      ;         $          C          0   F   >   <      1           6   8          ,         
          5   -   7                  (   B       +      	                 day  days  days &Keyword delimiter: &Name: - web short cut (e.g. gg): what it refers to (e.g. Google)- %1: "%2" <p>Marks partially uploaded FTP files.</p><p>When this option is enabled, partially uploaded files will have a ".part" extension. This extension will be removed once the transfer is complete.</p> <p>Marks partially uploaded files through SMB, SFTP and other protocols.</p><p>When this option is enabled, partially uploaded files will have a ".part" extension. This extension will be removed once the transfer is complete.</p> <qt>
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
</qt> <qt>Attempt automatic discovery of the environment variables used for setting system wide proxy information.<p> This feature works by searching for commonly used variable names such as HTTP_PROXY, FTP_PROXY and NO_PROXY.</qt> @info:whatsthis<para>Check this box to allow <emphasis strong='true'>automatic deletion</emphasis> of files that are older than the value specified. Leave this disabled to <emphasis strong='true'>not</emphasis> automatically delete any items after a certain timespan</para> @info:whatsthis<para>Check this box to limit the trash to the maximum amount of disk space that you specify below. Otherwise, it will be unlimited.</para> @info:whatsthis<para>Set the number of days that files can remain in the trash. Any files older than this will be automatically deleted.</para> @info:whatsthis<para>This is the calculated amount of disk space that will be allowed for the trash, the maximum.</para> @info:whatsthis<para>This is the maximum percent of disk space that will be used for the trash.</para> @info:whatsthis<para>When the size limit is reached, it will prefer to delete the type of files that you specify, first. If this is set to warn you, it will do so instead of automatically deleting files.</para> @item:inlistbox The default character setDefault @title:columnKeywords @title:columnPreferred @title:windowUpdate Failed Auto D&etect Choose the delimiter that separates the keyword from the phrase or word to be searched. Cleanup: Colon as keyword delimiterColon Connect to the Internet directly. De&lete Delete files older than Disable Passive FTP Enable passive &mode (PASV) Enables FTP's "passive" mode. This is required to allow FTP to work from behind firewalls. Enter the address for the proxy configuration script. Enter the address of the FTP proxy server. Enter the address of the HTTP proxy server. Enter the address of the HTTPS proxy server. Enter the address of the SOCKS proxy server. Enter the human-readable name of the search provider here. Enter the port number of the FTP proxy server. Enter the port number of the HTTP proxy server. Enter the port number of the HTTPS proxy server. Enter the port number of the SOCKS proxy server. Exceptions: FTP Options Global Options Keep It Limit to Manually enter proxy server configuration information. Mark &partially uploaded files Mark partially uploaded files Port: Search F&ilters Select the character set that will be used to encode your search query Select the character set that will be used to encode your search query. Show the &value of the environment variables Size: Space as keyword delimiterSpace Use manually specified proxy configuration: Use the specified proxy script to configure the proxy settings. Use this proxy server for a&ll protocols When FTP connections are passive the client connects to the server, instead of the other way round, so firewalls do not block the connection; old FTP servers may not support Passive FTP though. While a file is being uploaded its extension is ".part". When fully uploaded it is renamed to its real name. You have to restart the running applications for these changes to take effect. Project-Id-Version: kcmkio
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2021-08-27 01:43+0300
Last-Translator: Moo
Language-Team: Lithuanian <kde-i18n-lt@kde.org>
Language: lt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=4; plural=(n==1 ? 0 : n%10>=2 && (n%100<10 || n%100>=20) ? 1 : n%10==0 || (n%100>10 && n%100<20) ? 2 : 3);
X-Generator: Poedit 2.3
  diena  dienos  dienų  diena  dienų Ra&ktažodžių skirtukas: &Vardas: - %1: "%2" <p>Žymi iš dalies nusiųstus į serverį FTP failus</p> <p>Įjungus šią parinktį nebaigti siųsti failai turės „.part“ išplėtimą. Šis išplėtimas bus panaikintas pabaigus siuntimą.</p> <p>Žymi iš dalies įkeltus failus siunčiant juos SMB, SFTP ir kitais protokolais.</p><p>Įjungus šią parinktį nebaigti siųsti failai turės „.part“ prievardį. Šis prievardis bus panaikintas pabaigus siuntimą.</p> <qt>
<p>Įveskite kableliais atskirtą sąrašą kompiuterių vardų ar IP adresų, kurie būtų išskirti iš panaudojimo įgaliotojo serverio nuostatose aukščiau.</p>
<p>Jei norite išskirti visus mazgus duotai sričiai, paprasčiausiai įveskite srities vardą su tašku priešais. Pavyzdžiui, kad išskirti visų kompiuterių vardus iš <i>kde.org</i>, įveskite <i>.kde.org</i>. Pakaitos simboliai tokie kaip „*“ arba „?“ nėra palaikomi ir nebus jokio efekto.</p>
<p>Papildomai, galite įvesti IP adresus, pvz.: 127.0.0.1 ir IP adresus su potinkliais, pvz.: 192.168.0.1/24.</p>
</qt> Naudoti įgaliotojo serverio nuostatas tik įrašams, esantiems išimčių sąraše <qt>
Įveskite URI kuris yra naudojamas paieškai paieškos varikliuke.<br/>Visas ieškomas tekstas gali būti nurodytas kaip \{@} arba \{0}.<br/>
Rekomenduojama yra \{@}, kadangi tai ištrina visus paieškos nustatymus (vardas=reikšmė) iš rezultatų eilutės, tuo tarpu vietoje \{0} bus nepakeista užklausos eilutėje. <br/> Jūs galite panaudoti \{1}... \{n}, kad apibrėžtumėte tam tikrus žodžius iš užklausos ir \{vardas}, kad apibrėžtumėte vertę, duotą "vardas=reikšmė" naudotojo užklausoje. <br/> Be to, galima apibrėžti daugelį užuominų (vardų, skaičių ir eilučių) iš karto (\{vardas1, vardas2..., "eilutė "}). <br/> Pirma atitinkanti reikšmė (iš kairės) bus panaudota kaip pakeitimo vertė galutiniam URI. <br/>Kabutėmis išskirta eilutė  gali būti panaudota kaip numatytoji vertė, jei niekas nederi iš kairės aprašų sąrašo 
</qt> <qt>
Įveskite aplinkos kintamojo vardą, pvz. <b>NO_PROXY</b>, naudojamą svetainių adresų, kuriems įgaliotasis serveris serveris neturėtų būti naudojamas, išsaugojimui.<p>
Taip pat, norėdami pamėginti automatiškai rasti šį kintamąjį, galite spragtelėti mygtuką <b>„Aptikti automatiškai“</b>.
</qt> <qt>
Įveskite aplinkos kintamojo vardą, pvz. <b>FTP_PROXY</b>, panaudotą FTP įgaliotojo serverio adresui išsaugoti.<p>
Taip pat, norėdami pamėginti automatiškai rasti šį kintamąjį, galite spragtelėti mygtuką <b>„Aptikti automatiškai“</b>.</p>
</qt> <qt>
Įveskite aplinkos kintamojo vardą, pvz. <b>HTTPS_PROXY</b>, panaudotą HTTPS įgaliotojo serverio adresui išsaugoti.<p>
Taip pat, norėdami pamėginti automatiškai rasti šį kintamąjį, galite spragtelėti mygtuką <b>„Aptikti automatiškai“</b>.</p>
</qt> <qt>
Įveskite aplinkos kintamojo vardą, pvz. <b>HTTP_PROXY</b>, panaudotą HTTP proxy serverio adresui išsaugoti.<p>
Taip pat, norėdami pamėginti automatiškai rasti šį kintamąjį, galite spragtelėti mygtuką <b>„Aptikti automatiškai“</b>.</p>
</qt> <qt>
Įveskite aplinkos kintamojo vardą, pvz. <b>SOCKS_PROXY</b>, panaudotą HTTPS įgaliotojo serverio adresui išsaugoti.<p>
Taip pat, norėdami pamėginti automatiškai rasti šį kintamąjį, galite spragtelėti mygtuką <b>„Aptikti automatiškai“</b>.</p>
</qt> <qt>
Pasirinkite paieškos variklį, kuris atliks paiešką, kai į laukelį įvesite ne URL, o paprastą žodį ar frazę. Norėdami išjungti tokios paieškos galimybę iš sąrašo išsirinkite <b>Nieko</b>.
</qt> <qt>
Nustatyti įgaliotojo serverio konfigūraciją.
<p>
Įgaliotasis serveris serveris yra tarpinis kompiuteris, esanti tarp Jūsų kompiuterio ir interneto ir teikianti tokias paslaugas, kaip žiniatinklio puslapių kaupimas ir filtravimas. Kaupiantys įgaliotieji serveriai suteikia Jums greitesnį prisijungimą prie žiniatinklio svetainių, kuriose jau esate lankęsi, nes jie vietoje saugo tuos puslapius. Filtruojantys įgaliotieji serveriai serveriai paprastai suteikia galimybę blokuoti reklamas, šiukšles ar bet ką kitą, ką norite blokuoti.
<p>
Jei nesate tikras, ar Jums, prisijungimui prie Interneto, reikalingas įgaliotasis serveris serveris, pasižiūrėkite į jūsų interneto paslaugų tiekėjo nustatymų vadovą, arba susisiekite su sistemos administratoriumi.
</qt> <qt><p>Naudoti įgaliotojo serverio nuostatas nurodytus sistemoje.</p>
<p>Kai kurios platformos siūlo sistemai taikomus įgaliotojo serverio konfigūraciją ir informaciją nuostatas, šio parinkties pasirinkimas leidžia Jums naudoti tas nuostatas.</p>
<p>Mac platformos</p>
<p>Windows platformos</p>
<p>Unix ir Linux platformos, tokie sistemos įgaliotojo serverio nuostatos dažniausiai per aplinkos kintamuosius. Sekantys aplinkos kintamieji būna aptikti ir naudojami jei yra: <b>HTTP_PROXY</b>, <b>HTTPS_PROXY</b>, <b>FTP_PROXY</b>, <b>NO_PROXY</b>.</p>
</qt> <qt>Bandyti automatiškai rasti aplinkos kintamuosius, naudojamus nustatant visos sistemos įgaliotojo serverio informaciją. <p>  Ši savybė veikia ieškodama paprastai naudojamų kintamųjų vardų, tokių, kaip HTTP_PROXY, FTP_PROXY ir NO_PROXY.</qt> <para>Įjunkite šią parinktį, jei norite leisti <emphasis strong='true'>automatinį trynimą</emphasis> failų, kurie yra senesni nei nurodyta reikšmė. Neįjunginėkite šios parinkties, jei <emphasis strong='true'>nenorite</emphasis> automatiškai trinti elementus po nurodyto laiko.</para> <para>Įjunkite šią parinktį, jei norite apriboti šiukšlinės dydį. Priešingu atveju šiukšlinės dydis neribojamas.</para> <para>Nurodykite, kiek dienų failai turėtų likti šiukšlinėje. Bet kokie failai, senesni nei nurodytas dienų skaičius bus ištrinti.</para> <para>Tai yra paskaičiuotas didžiausias vietos diske kiekis, kuris bus naudojamas šiukšlinei.</para> <para>Čia yra didžiausias vietos diske kiekis (procentais), kuris bus naudojamas šiukšlinėje.</para> <para>Pasiekus dydžio apribojimą, iš pradžių bus trinami jūsų nurodyto tipo failai. Jei čia nurodyta įspėti, taip ir bus padaryta, vietoje automatinio failų trynimo.</para> Numatytas Raktažodžiai Pageidautinas Atnaujinimas nepavyko Aptikti &automatiškai Pasirinkite skirtuką kuris skirs raktažodį nuo frazės ar žodžio kurios ieškosite. Išvalyti: Dvitaškis Jungtis prie Interneto tiesiogiai. &Trinti Trinti failus, senesnius nei Išjungti pasyvųjį FTP Įjungti pasyvią &veikseną (PASV) Įjungia FTP „pasyvią“ veikseną. Šito reikia norint naudoti FTP už ugniasienių. Įveskite įgaliotojo serverio konfigūravimo scenarijaus adresą. Įveskite FTP įgaliotojo serverio adresą. Įveskite HTTP įgaliotojo serverio adresą. Įveskite HTTPS įgaliotojo serverio adresą. Įveskite SOCKS įgaliotojo serverio adresą. Įvesti paieškos tiekėjo žmogui suprantamą vardą. Įveskite FTP įgaliotojo serverio adresą. Įveskite HTTP įgaliotojo serverio adresą. Įveskite HTTPS įgaliotojo serverio adresą. Įveskite SOCKS įgaliotojo serverio adresą. Išimtys: FTP parinktys Visuotinės parinktys Palikti Apriboti iki Rankiniu būdu įvesti įgaliotojo serverio konfigūravimo informaciją. Žymėti iš &dalies nusiųstus failus Žymėti iš dalies nusiųstus failus Prievadas: &Paieškos filtrai Pasirinkite koduotę, kuri bus naudojama jūsų paieškose Pasirinkti koduotę kuri bus naudojama koduoti paieškos žodžius. Rodyti aplinkos &kintamųjų reikšmes Dydis: Tarpas Naudoti rankiniu būdu įvestą įgaliotojo serverio konfigūraciją: Naudokite nurodytą įgaliotojo serverio scenarijų nuostatų konfigūravimui. Naudoti šį įgaliotąjį serverį &visiems protokolams Kai FTP prisijungimai yra pasyvūs, klientas yra prisijungęs prie serverio, o ne atvirkščiai, taigi, ugniasienės neblokuoja tokio prisijungimo; seni FTP serveriai gali ir nepalaikyti pasyvaus FTP. Kol failo išsiuntimas nebaigtas, jos priesaga yra „.part“, kai siuntimas baigtas, jo pavadinimas pakeičiamas į tikrąjį. Kad pakeitimai turėtų poveikį, Jūs turite perstartuoti veikiančias programas. 