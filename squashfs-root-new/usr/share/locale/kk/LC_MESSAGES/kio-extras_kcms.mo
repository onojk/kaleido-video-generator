��    +      t  ;   �      �     �  �   �    �  �   �      �   *  �   &	  �   &
  �   !  s  !  �  �  �   �     n     �  !   �     �     �     �  Z   �  5   L  *   �  +   �  ,   �  ,     .   3  /   b  0   �  0   �     �        6        C     b     �  ,   �     �  +   �  ?   �  (   %  �   N  l     N   }    �     L  f  Y    �  �   �  �  �  a    e  p   c  �!  d  :#  �  �$    ^(  x  o+     �,     -  1   -     P-  ,   \-  7   �-  �   �-  S   �.  B   �.  I   #/  D   m/  D   �/  K   �/  L   C0  M   �0  M   �0     ,1     H1  N   e1  X   �1  Y   2     g2  R   s2     �2  P   �2  ^   %3  e   �3  �  �3  �   l5  �   >6        !         "                 '                          %       #       
              $      )      +           	      &                         *            (                                           &Name: <p>Marks partially uploaded FTP files.</p><p>When this option is enabled, partially uploaded files will have a ".part" extension. This extension will be removed once the transfer is complete.</p> <qt>
<p>Enter a comma separated list of hostnames or ip addresses that should be excluded from using the above proxy settings.</p>
<p>If you want to exclude all hosts for a given domain, then simply enter the domain name preceded by a dot. For example, to exclude all hostnames for <i>kde.org</i>, enter <i>.kde.org</i>. Wildcard characters such as '*' or '?' are not supported and will have no effect.</p>
<p>Additionally, you can also enter IP addresses, e.g. 127.0.0.1 and IP addresses with a subnet, e.g. 192.168.0.1/24.</p>
</qt> <qt>
Check this box if you want the above proxy settings to apply only to the addresses listed in the <i>Exceptions</i> list.</qt> <qt>
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
</qt> <qt>Attempt automatic discovery of the environment variables used for setting system wide proxy information.<p> This feature works by searching for commonly used variable names such as HTTP_PROXY, FTP_PROXY and NO_PROXY.</qt> @title:windowUpdate Failed Auto D&etect Connect to the Internet directly. De&lete Disable Passive FTP Enable passive &mode (PASV) Enables FTP's "passive" mode. This is required to allow FTP to work from behind firewalls. Enter the address for the proxy configuration script. Enter the address of the FTP proxy server. Enter the address of the HTTP proxy server. Enter the address of the HTTPS proxy server. Enter the address of the SOCKS proxy server. Enter the port number of the FTP proxy server. Enter the port number of the HTTP proxy server. Enter the port number of the HTTPS proxy server. Enter the port number of the SOCKS proxy server. Exceptions: FTP Options Manually enter proxy server configuration information. Mark &partially uploaded files Mark partially uploaded files Port: Show the &value of the environment variables Size: Use manually specified proxy configuration: Use the specified proxy script to configure the proxy settings. Use this proxy server for a&ll protocols When FTP connections are passive the client connects to the server, instead of the other way round, so firewalls do not block the connection; old FTP servers may not support Passive FTP though. While a file is being uploaded its extension is ".part". When fully uploaded it is renamed to its real name. You have to restart the running applications for these changes to take effect. Project-Id-Version: kcmkio
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2012-12-31 04:15+0600
Last-Translator: Sairan Kikkarin <sairan@computer.org>
Language-Team: Kazakh <kde-i18n-doc@kde.org>
Language: kk
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Lokalize 1.2
Plural-Forms: nplurals=1; plural=0;








 &Атауы: <p>Жарым-жарты жүктеп берілген FTP файлдарды белгілеу.</p><p>Бұл параметр рұқсат етілсе жарым-жарты жүктелген файлдарға ".part" деген жұрнақ ілектіріледі. Жүктеуі болғасын бұл жұрнақ алынып тасталады.</p> <qt>
<p>Жөғардағы прокси параметрлеріне бағынбайтын, үтірлермен бөліктелген хосттар не IP-адрестерінің тізімін келтіріңіз.</p>
<p>Егерде толығымен бір доменді бағынбайтын қылам десеңіз, онда алдында нүкте қойып доменнің атауын келтіріңіз. Мысалы, түгел<i>kde.org</i> кірмейтін болса <i>.kde.org</i> деп қойыңыз. Бұнда '*' немесе '?' қалқа белгілері істемейді.</p>
<p>Оған қоса, IP адресті (мысалы: e.g. 127.0.0.1) субжелі IP адресін (мысалы: 192.168.0.1/24) келтіре аласыз.</p>
</qt> <qt>
Прокси тек <i>Ерекшеліктері</i> тізімдегілер үшін қолданылсындесеңіз - осыны белгілеңіз.</qt> <qt>
Прокси сервер қолданбайтынын сайттар адрестерін сақтайтын орта айнымалының атауын келтіріңіз, мысалы <b>NO_PROXY</b>.<p>
Әлде, бұл айнымалыны автоматты түрде анықтап көру үшін <b>"Автобайқау"</b> батырмасын басыңыз.
</qt> <qt>
FTP прокси сервердің адресін сақтайтын орта айнымалының атауын келтіріңіз, мысалы <b>FTP_PROXY</b>.<p>
Әлде, бұл айнымалыны автоматты түрде анықтап көру үшін <b>"Автобайқау"</b> батырмасын басыңыз.</p>
</qt> <qt>
HTTPS прокси сервердің адресін сақтайтын орта айнымалының атауын келтіріңіз, мысалы <b>HTTPS_PROXY</b>.<p>
Әлде, бұл айнымалыны автоматты түрде анықтап көру үшін <b>"Автобайқау"</b> батырмасын басыңыз.</p>
</qt> <qt>
HTTP прокси сервердің адресін сақтайтын орта айнымалының атауын келтіріңіз, мысалы <b>HTTP_PROXY</b>.<p>
Әлде, бұл айнымалыны автоматты түрде анықтап көру үшін <b>"Автобайқау"</b> батырмасын басыңыз.</p>
</qt> <qt>
SOCKS прокси сервердің адресін сақтайтын орта айнымалының атауын келтіріңіз, мысалы <b>SOCKS_PROXY</b><p>
Әлде, бұл айнымалыны автоматты түрде анықтап көру үшін <b>"Автобайқау"</b> батырмасын басыңыз.</p>
</qt> <qt>
Прокси конфигурациясын орнату.
<p>
Прокси-сервер деген компьютеріңіз бен Интернеттің арасындағы компьютер. Ол веб-парақтарды кэштеп және сүзгілеп отырады. Кэштеу прокси сервері бұрын жолыққан сайттарының мазмұнын сақтап, қайта ашуды тездететін компьютер. Сүзгілеу жарнама, спам немесе басқа да қажетсіз мәліметтерді бұғаттауға мүмкіншілік береді.
<p>
Интернетке қосылу үшін прокси серверді қолдануы қажет пе екенін білмесеңіз, Интернет провайдеріңіздің қосылу туралы нұсқауын қараңыз не жүйе әкімшісінен сұраңыз.
</qt> <qt><p>Жүйелік деңгейде анықталатын прокси параметрлерін қолдану.</p>
<p>Кейбір платформалар бүкіл жүйелік прокси параметрлерін ұсынады, осыны таңдап оларды қолдануға болады.</p>
<p>Mac платформасындағы</p>
<p>Windows платформасындағы</p>
<p>Unix пен Linux платформаларында бұл жүйелік прокси параметрлері әдетте ортаңың айнымалылар арқылы беріледі. Келесі айнымалылар күтіліп, бар болса пайдаланады: <b>HTTP_PROXY</b>, <b>HTTPS_PROXY</b>, <b>FTP_PROXY</b>, <b>NO_PROXY</b>.</p>
</qt> <qt>Жалпы жүйелік прокси ақпараты үшін қолданылатын орта айнымалыларды автоматты түрде анықтау әрекетін жасау. <p>Бұл HTTP_PROXY, FTP_PROXY, NO_PROXY секілді әдетте қолданылатын айнымалырарды іздеу арқылы орындалады.</qt> Жаңарту жаңылысы &Автобайқау Интернетке тікелей қосылу. Өші&ру Пассивті FTP рұқсат етпеу Пассивті &күйін (PASV) рұқсат ету "Пассивті" күйдегі FTP қызметін рұқсат ету. Бұл FTP-ге желіаралық қалқанның артынан істеуді рұқсат ету үшін керек. Прокси баптау скриптінің адресін келтіріңіз. FTP прокси сервердің адресін келтіру. HTTP прокси сервердің адресін келтіріңіз. HTTPS прокси сервердің адресін келтіру. SOCKS прокси сервердің адресін келтіру. FTP прокси сервердің порт нөмірін келтіру. HTTP прокси сервердің порт нөмірін келтіру. HTTPS прокси сервердің порт нөмерін келтіру. SOCKS прокси сервердің порт нөмірін келтіру. Ерекшеліктері: FTP параметрлері Проксидің конфигурациясын қолмен келтіру. &Жарым-жарты жүктеп берілген файлдарды белгілеу Жарым-жарты жүктеліп алынған файлдарды белгілеу Порты: Ортаның айнымалылардың &мәндері көрсетілсін Өлшемі: Қолмен келтірілген прокси конфигурациясы:ы Проксиді баптау үшін келтірілген скриптті қолдану. Барлық протоколдар үшін осы прокси сервер қ&олданылсын Пассивті FTP қосылымда клиент сервермен байланыс құрады, ал белсенді FTP қосылымда керсінше, бірншісінде желіаралық қалқандар қосылымды бұғаттамайды, бірақ кейбір ескі FTP серверлері пассивті FTP дегенді білмейді. Жүктеліп алынып жатқан файлға ".part" деген жұрнақ ілектіріледі. Жүктеуі біткен соң файлға өзінің атауы қайтарылады. Өзгерістер күшіне ену үшін орындалып тұрған қолданбаларды қайта іске қосу керек. 