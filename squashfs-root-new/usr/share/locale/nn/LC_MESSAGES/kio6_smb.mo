��          �      l      �  G   �  _   )  1   �  >   �  �   �  �  �     @      T  /   u  3   �  =   �       C   1  (   u  �   �  a   M  (   �  p   �  %   I	  �  o	  �  '  :   �     3  -   P  7   ~  !   �  �  �     y  "   �  1   �  7   �  L        i  B   �      �  �   �  I   �  $   �  '   	  ,   1  �  ^               
                                      	                                             
Make sure that the samba package is installed properly on your system. %1 is an error number, %2 either a pretty string or the numberUnknown error condition: [%1] %2 %1:
Unknown file type, neither directory or file. <qt>Please enter authentication information for <b>%1</b></qt> @info:status smb failed to reach the server (e.g. server offline or network failure). %1 is an ip address or hostname%1: Host unreachable @info:whatsthis<para>There are various options for authenticating on SMB shares.</para><para><placeholder>username</placeholder>: When authenticating within a home network the username on the server is sufficient</para><para><placeholder>username@domain.com</placeholder>: Modern corporate logon names are formed like e-mail addresses</para><para><placeholder>DOMAIN\username</placeholder>: For ancient corporate networks or workgroups you may need to prefix the NetBIOS domain name (pre-Windows 2000)</para><para><placeholder>anonymous</placeholder>: Anonymous logins can be attempted using empty username and password. Depending on server configuration non-empty usernames may be required</para> Bad file descriptor Could not connect to host for %1 Error occurred while trying to access %1<nl/>%2 Error while connecting to server responsible for %1 Mounting of share "%1" from host "%2" by user "%3" failed.
%4 No media in device for %1 Please enter authentication information for:
Server = %1
Share = %2 Share could not be found on given server The given name could not be resolved to a unique server. Make sure your network is setup without any name conflicts between names used by Windows and by UNIX name resolution. Unable to find any workgroups in your local network. This might be caused by an enabled firewall. Unmounting of mountpoint "%1" failed.
%2 host entry when no pretty name is available. %1 likely is an IP addressUnknown Device @ <resource>%1</resource> libsmbclient failed to create context libsmbclient reported an error, but did not specify what the problem is. This might indicate a severe problem with your network - but also might indicate a problem with libsmbclient.
If you want to help us, please provide a tcpdump of the network interface while you try to browse (be aware that it might contain private data, so do not post it if you are unsure about that - you can send it privately to the developers if they ask for it) Project-Id-Version: kio_smb
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2020-11-05 19:24+0100
Last-Translator: Karl Ove Hufthammer <karl@huftis.org>
Language-Team: Norwegian Nynorsk <l10n-no@lister.huftis.org>
Language: nn
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Lokalize 20.08.2
Plural-Forms: nplurals=2; plural=n != 1;
X-Environment: kde
X-Accelerator-Marker: &
X-Text-Markup: kde4
 
Sjå til at samba-pakken er rett installert på systemet. Ukjend feiltilstand: [%1] %2 %1:
Ukjend filtype, verken katalog eller fil. <qt>Oppgje autentiseringsinformasjon for <b>%1</b></qt> %1: Fekk ikkje kontakt med verten <para>Det finst fleire val for autentisering for SMB-ressursar.</para><para><placeholder>brukarnamn</placeholder>: Ved autentisering på heime­nettverket held det med brukarnamnet.</para><para><placeholder>brukarnnamn@domene.no</placeholder>: Brukarnamn for moderne firma­nettverk er utforma som e-postadresser.</para><para><placeholder>DOMENE\brukarnamn</placeholder>: Eldre firma­nettverk og arbeids­grupper NetBIOS-domene­namnet som prefiks (pre-Windows 2000)</para><para><placeholder>anonym</placeholder>: Du kan prøva anonym pålogging ved å bruka eit tomt brukarnamn og passord. Ved nokre tenar­oppsett er det nødvendig med eit ikkje-tomt brukarnamn.</para> Dårleg fildeskriptor Klarte ikkje kopla til vert for %1 Feil ved forsøk på å få tilgang til %1<nl/>%2 Feil ved tilkopling til tenaren som er ansvarleg for %1 Brukaren «%3» klarte ikkje montera ressursen «%1» frå verten «%2».
%4 Ingen medium i eininga for %1 Oppgje autentiseringsinformasjon for:
Tenar = %1
Delt ressurs = %2 Fann ikkje ressursen på tenaren Det namnet som er oppgjeve svarte ikkje til ein eintydig tenar. Sjå etter at nettet er sett opp utan konfliktar mellom namn som er brukte i namnesystema til Windows og UNIX. Fann ingen arbeidsgrupper i lokalnettet. Dette kan skuldast ein brannmur. Avmontering av «%1» mislukkast.
%2 Ukjend eining @ <resource>%1</resource> libsmbclient klarte ikkje oppretta samanheng libsmbclient melde om ein feil, men sa ikkje noko om kva problemet er. Dette kan tyda på eit alvorleg problem med nettverket, men kan òg skuldast feil i libsmbclient.
Dersom du vil hjelpa til, kan du skaffa ein tcpdump av nettverksgrensesnittet mens du prøver å kopla til. (Legg merke til at dumpen kan innehalda privat informasjon. Du kan senda han privat til ein av utviklarane om dei ber om det.) 