��          �      l      �  G   �  _   )  1   �  >   �  �   �  �  �     @      T  /   u  3   �  =   �       C   1  (   u  �   �  a   M  (   �  p   �  %   I	  �  o	  �  '  S   �        1   (  ;   Z     �  �  �     �  ,   �  1   �  9   &  I   `  $   �  A   �  *     �   <  q   �  !   b  (   �  .   �  �  �               
                                      	                                             
Make sure that the samba package is installed properly on your system. %1 is an error number, %2 either a pretty string or the numberUnknown error condition: [%1] %2 %1:
Unknown file type, neither directory or file. <qt>Please enter authentication information for <b>%1</b></qt> @info:status smb failed to reach the server (e.g. server offline or network failure). %1 is an ip address or hostname%1: Host unreachable @info:whatsthis<para>There are various options for authenticating on SMB shares.</para><para><placeholder>username</placeholder>: When authenticating within a home network the username on the server is sufficient</para><para><placeholder>username@domain.com</placeholder>: Modern corporate logon names are formed like e-mail addresses</para><para><placeholder>DOMAIN\username</placeholder>: For ancient corporate networks or workgroups you may need to prefix the NetBIOS domain name (pre-Windows 2000)</para><para><placeholder>anonymous</placeholder>: Anonymous logins can be attempted using empty username and password. Depending on server configuration non-empty usernames may be required</para> Bad file descriptor Could not connect to host for %1 Error occurred while trying to access %1<nl/>%2 Error while connecting to server responsible for %1 Mounting of share "%1" from host "%2" by user "%3" failed.
%4 No media in device for %1 Please enter authentication information for:
Server = %1
Share = %2 Share could not be found on given server The given name could not be resolved to a unique server. Make sure your network is setup without any name conflicts between names used by Windows and by UNIX name resolution. Unable to find any workgroups in your local network. This might be caused by an enabled firewall. Unmounting of mountpoint "%1" failed.
%2 host entry when no pretty name is available. %1 likely is an IP addressUnknown Device @ <resource>%1</resource> libsmbclient failed to create context libsmbclient reported an error, but did not specify what the problem is. This might indicate a severe problem with your network - but also might indicate a problem with libsmbclient.
If you want to help us, please provide a tcpdump of the network interface while you try to browse (be aware that it might contain private data, so do not post it if you are unsure about that - you can send it privately to the developers if they ask for it) Project-Id-Version: kio_smb
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2022-10-31 22:18+0000
Last-Translator: Gummi <gudmundure@gmail.com>
Language-Team: Icelandic <kde-i18n-doc@kde.org>
Language: is
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Lokalize 22.08.2
Plural-Forms: Plural-Forms: nplurals=2; plural=n != 1;


 
Gakktu úr skugga um að allir sambapakkar séu rétt uppsettir á kerfinu þínu. Óþekkt villuskilyrði: [%1] %2 %1:
Óþekkt skrárgerð, hvorki mappa né skrá. <qt>Sláðu inn auðkennisupplýsingar fyrir <b>%1</b></qt> %1: Ekki næst í hýsitölvu <para>Nokkrir valkostir eru í boði til að auðkenna SMB-sameignir.</para><para><placeholder>username</placeholder>: Þegar auðkennt erá heimaneti nægir að gefa upp notandanafnið á þjóninum</para><para><placeholder>username@domain.com</placeholder>: Í dag eru innskráningarheiti fyrirtækja sett fram eins og tölvupóstföng</para><para><placeholder>DOMAIN\username</placeholder>: Í eldri fyrirtækjanetum eða vinnuhópum þarf hugsanlega að nota NetBIOS-lénsheitið sem forskeyti (fyrir daga Windows 2000)</para><para><placeholder>anonymous</placeholder>: Hægt er að prófa nafnlausa innskráningu með því að hafa reitina fyrir notandanafn og lykilorð auða. Það veltur á þjóninum hvort þessir reitir þurfi að vera útfylltir</para> Skemmd skrárlýsing Ekki tókst að tengjast þjóninum fyrir %1 Villa kom upp þegar reynt var að opna %1<nl/>%2 Villa við að tengjast þjóninum sem ber ábyrgð á %1 Tenging við sameignina "%1" frá vél "%2" og notanda "%3" mistókst.
%4 Enginn diskur er í drifinu fyrir %1 Sláðu inn auðkenniupplýsingar fyrir:
Þjón = %1
Sameign = %2 Sameign fannst ekki á tilgreindum þjóni Ekki var hægt að tengja tilgreint heiti við tiltekna vél. Gakktu úr skugga um að netuppsetning þín sé án árekstra á milli heita í nafngreiningu Windows og UNIX véla. Engir vinnuhópar fundust á netinu þínu. Ástæðan gæti verið að þú sért með virkan eldvegg uppsettan. Ekki tókst að aftengja "%1".
%2 Óþekkt tæki @ <resource>%1</resource> libsmbclient tókst ekki að búa til samhengi libsmbclient tilkynnti villu, en tilgreindi ekki vandamálið. Þetta gæti gefið til kynna að eitthvað alvarlegt sé að netinu þínu, en gæti einnig bent til vandamála í libsmbclient.
Ef þú vilt hjálpa okkur geturðu látið okkur fá 'tcpdump' af nettækinu þínu á meðan þú reynir að vafra (taktu eftir að það gæti innihaldið einkagögn og því skaltu ekki senda það ef þú ert ekki viss - þú getur sent gögnin beint til forritarana ef þeir biðja þig um það) 