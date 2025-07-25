��          �      l      �  G   �  _   )  1   �  >   �  �   �  �  �     @      T  /   u  3   �  =   �       C   1  (   u  �   �  a   M  (   �  p   �  %   I	  �  o	  �  '  z   �  *   z  ?   �  V   �  %   <  �  b  ,     7   /  a   g  T   �  u     0   �  �   �  T   R    �  �   �  S   j  ;   �  B   �  �  =               
                                      	                                             
Make sure that the samba package is installed properly on your system. %1 is an error number, %2 either a pretty string or the numberUnknown error condition: [%1] %2 %1:
Unknown file type, neither directory or file. <qt>Please enter authentication information for <b>%1</b></qt> @info:status smb failed to reach the server (e.g. server offline or network failure). %1 is an ip address or hostname%1: Host unreachable @info:whatsthis<para>There are various options for authenticating on SMB shares.</para><para><placeholder>username</placeholder>: When authenticating within a home network the username on the server is sufficient</para><para><placeholder>username@domain.com</placeholder>: Modern corporate logon names are formed like e-mail addresses</para><para><placeholder>DOMAIN\username</placeholder>: For ancient corporate networks or workgroups you may need to prefix the NetBIOS domain name (pre-Windows 2000)</para><para><placeholder>anonymous</placeholder>: Anonymous logins can be attempted using empty username and password. Depending on server configuration non-empty usernames may be required</para> Bad file descriptor Could not connect to host for %1 Error occurred while trying to access %1<nl/>%2 Error while connecting to server responsible for %1 Mounting of share "%1" from host "%2" by user "%3" failed.
%4 No media in device for %1 Please enter authentication information for:
Server = %1
Share = %2 Share could not be found on given server The given name could not be resolved to a unique server. Make sure your network is setup without any name conflicts between names used by Windows and by UNIX name resolution. Unable to find any workgroups in your local network. This might be caused by an enabled firewall. Unmounting of mountpoint "%1" failed.
%2 host entry when no pretty name is available. %1 likely is an IP addressUnknown Device @ <resource>%1</resource> libsmbclient failed to create context libsmbclient reported an error, but did not specify what the problem is. This might indicate a severe problem with your network - but also might indicate a problem with libsmbclient.
If you want to help us, please provide a tcpdump of the network interface while you try to browse (be aware that it might contain private data, so do not post it if you are unsure about that - you can send it privately to the developers if they ask for it) Project-Id-Version: fc57ad16a28d02dea100ceb1c60de14e
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2024-06-01 05:50
Last-Translator: Darafei Praliaskouski <komzpa@licei2.com>
Language-Team: Belarusian
Language: be
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.11.4
Plural-Forms: nplurals=4; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<12 || n%100>14) ? 1 : n%10==0 || n%10>=5 && n%10<=9 || n%100>=11 && n%100<=14 ? 2 : 3);
X-Crowdin-Project: fc57ad16a28d02dea100ceb1c60de14e
X-Crowdin-Project-ID: 136
X-Crowdin-Language: be
X-Crowdin-File: /[antikruk.KDE] main/KDE6/be/messages/kio-extras/kio6_smb.po
X-Crowdin-File-ID: 10134
 
Пераканайцеся, што пакет samba правільна ўсталяваны ў вашай сістэме. Невядомая памылка: [%1] %2 %1:
Невядомы тып каталога або файла. <qt>Увядзіце звесткі аўтэнтыфікацыі для <b>%1</b></qt> %1: хост недасягальны <para>Існуюць розныя варыянты аўтэнтыфікацыі SMB.</para><para><placeholder>імя карыстальніка</placeholder>: пры аўтэнтыфікацыі ў хатняй сетцы дастаткова імя карыстальніка на серверы</para><para><placeholder>username@domain.com</placeholder>: Сучасныя карпаратыўныя імёны для ўваходу робяцца як адрасы электроннай пошты</para><para><placeholder>ДАМЕН\імя карыстальніка</placeholder>: для старых карпаратыўных сетак або працоўных групаў вам могуць спатрэбіцца прэфікса даменнай назвы NetBIOS (да Windows 2000)</para><para><placeholder>ананімны ўваход</placeholder>: пры ананімным ўваходзе можна ўваходзіць з пустым імем карыстальніка і паролем; у залежнасці ад канфігурацыі сервера могуць спатрэбіцца непустыя імёны карыстальнікаў</para> Дрэнны дэскрыптар файла Не ўдалося злучыцца з хостам %1 Падчас спробы атрымаць доступ адбылася памылка %1<nl/>%2 Падчас злучэння з серверам адбылася памылка %1 Карыстальніку "%3" не ўдалося прымантаваць рэсурс "%1" з хоста "%2".
%4 Няма носьбіта ў прыладзе %1 Калі ласка, увядзіце звесткі аўтэнтыфікацыі для:
Сервер = %1
Агульны рэсурс = %2 Не ўдалося знайсці рэсурс на дадзеным серверы Сервер не можа быць вызначаны паводле дадзенай назвы. Пераканайцеся, што ваша сетка наладжаная без канфліктаў назваў, якія выкарыстоўваюцца ў Windows і UNIX. Не ўдалося знайсці працоўныя групы ў лакальнай сетцы. На гэта можа ўплываць ўключаны файрвол. Не ўдалося адмантаваць пункт мантавання "%1".
%2 Невядомая прылада @ <resource>%1</resource> libsmbclient не ўдалося стварыць кантэкст libsmbclient была адпраўленая справаздача пра памылку, але не было вызначана, што за праблема ўзнікла. Гэта можа сведчыць пра праблемы з серверам у вашай сетцы - аднак таксама можа сведчыць пра праблемы з libsmbclient.
Калі хочаце дапамагчы нам, калі ласка, падайце журнал tcpdump са звесткамі пра сеткавы інтэрфейс падчас спробы агляду (будзьце ўважлівыя, ён можа змяшчаць асабістыя звесткі, таму не адпраўляйце яго, калі не ўпэўненыя ў гэтым - вы можаце адправіць журанал распрацоўнікам, калі яны запытаюць яго) 