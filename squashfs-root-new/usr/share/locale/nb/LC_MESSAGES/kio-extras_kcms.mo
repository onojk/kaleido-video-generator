��    D      <  a   \      �  
   �     �     �       E     �   S  O       g  �   ~	  .  
    0  �   <  �   8  �   8  �   3  �   3  s    �    �   v  �   X  �   �  �   �  y   �  g   �  �   b  1   6     h     �     �  W   �        !   "     D     L     `  Z   |  5   �  *     +   8  ,   d  ,   �  :   �  .   �  /   (  0   X  0   �     �     �     �     �     �  6   �     3      R      p      v   F   �   G   �   ,   !     B!      H!  +   i!  ?   �!  (   �!  �   �!  l   �"  N   -#  �  |#     R%     ^%     e%     �%     �%  �   �%  R   u&    �&  {   �(  1  G)  �   y,  �   r-  �   Y.  �   ?/  �   #0  �   	1  A  �1    4  �   6     7  �   �7  w   u8  a   �8  U   O9  �   �9     z:     �:     �:     �:  _   �:     ;     ;     9;     @;     S;  x   m;  8   �;  *   <  +   J<  ,   v<  ,   �<  .   �<  .   �<  /   .=  /   ^=  0   �=     �=     �=     �=     �=     	>  ;   >      Q>     r>     �>     �>  =   �>  >   �>  "   !?     D?  	   P?      Z?  S   {?  /   �?  �   �?  �   �@  L   YA         2   #              $              <             D   +                 C   :       =           ,   !                                    6          /       0   B      1   '          4   7      8          "          @          -       ;   9   &   .           3   5          )         
              *   A                  %   ?   >   (      	               day  days  days &Keyword delimiter: &Name: - web short cut (e.g. gg): what it refers to (e.g. Google)- %1: "%2" <p>Marks partially uploaded FTP files.</p><p>When this option is enabled, partially uploaded files will have a ".part" extension. This extension will be removed once the transfer is complete.</p> <para>KDE's wastebin is configured to use the <b>Finder</b>'s Trash.<br></para> <qt>
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
</qt> <qt>Attempt automatic discovery of the environment variables used for setting system wide proxy information.<p> This feature works by searching for commonly used variable names such as HTTP_PROXY, FTP_PROXY and NO_PROXY.</qt> @info:whatsthis<para>Check this box to limit the trash to the maximum amount of disk space that you specify below. Otherwise, it will be unlimited.</para> @info:whatsthis<para>Emptying KDE's wastebin will remove only KDE's trash items, while<br>emptying the Trash through the Finder will delete everything.</para><para>KDE's trash items will show up in a folder called KDE.trash, in the Trash can.</para> @info:whatsthis<para>Set the number of days that files can remain in the trash. Any files older than this will be automatically deleted.</para> @info:whatsthis<para>This is the calculated amount of disk space that will be allowed for the trash, the maximum.</para> @info:whatsthis<para>This is the maximum percent of disk space that will be used for the trash.</para> @info:whatsthis<para>When the size limit is reached, it will prefer to delete the type of files that you specify, first. If this is set to warn you, it will do so instead of automatically deleting files.</para> @item:inlistbox The default character setDefault @title:columnPreferred @title:windowUpdate Failed Auto D&etect Choose the delimiter that separates the keyword from the phrase or word to be searched. Colon as keyword delimiterColon Connect to the Internet directly. De&lete Disable Passive FTP Enable passive &mode (PASV) Enables FTP's "passive" mode. This is required to allow FTP to work from behind firewalls. Enter the address for the proxy configuration script. Enter the address of the FTP proxy server. Enter the address of the HTTP proxy server. Enter the address of the HTTPS proxy server. Enter the address of the SOCKS proxy server. Enter the human-readable name of the search provider here. Enter the port number of the FTP proxy server. Enter the port number of the HTTP proxy server. Enter the port number of the HTTPS proxy server. Enter the port number of the SOCKS proxy server. Exceptions: FTP Options Insert query placeholder Keep It Limit to Manually enter proxy server configuration information. Mark &partially uploaded files Mark partially uploaded files Port: Search F&ilters Select the character set that will be used to encode your search query Select the character set that will be used to encode your search query. Show the &value of the environment variables Size: Space as keyword delimiterSpace Use manually specified proxy configuration: Use the specified proxy script to configure the proxy settings. Use this proxy server for a&ll protocols When FTP connections are passive the client connects to the server, instead of the other way round, so firewalls do not block the connection; old FTP servers may not support Passive FTP though. While a file is being uploaded its extension is ".part". When fully uploaded it is renamed to its real name. You have to restart the running applications for these changes to take effect. Project-Id-Version: kio4
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2015-04-28 08:48+0200
Last-Translator: Bjørn Steensrud <bjornst@skogkatt.homelinux.org>
Language-Team: Norwegian Bokmål <l10n-no@lister.huftis.org>
Language: nb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Lokalize 1.5
Plural-Forms: nplurals=2; plural=n != 1;
X-Environment: kde
X-Accelerator-Marker: &
X-Text-Markup: kde4
  dag  dager  dager S&killetegn for nøkkelord: &Navn: - %1: «%2» <p>Merker delvis overførte filer.</p><p> Når dette valget er slått på vil filer som ikke er ferdig overført få filnavn som slutter på «.part». Denne delen av filnavnet blir fjernet når overføringen er ferdig.</p> <para>KDEs søppelkasse er satt opp til å bruke <b>Finder</b>s Trash,<br> </para> <qt>
<p>Skriv inn en liste over vertsnavn eller IP-adresser der mellomtjenerinnstillingene over ikke skal brukes.</p>
<p>Hvis du vil utelate alle verter i et gitt domene. så bare skriv inn domenenavnet med et punktum foran. For eksempel,for å utelate alle vertsnavn i kde.org, så bare  skriv inn .kde.org. Jokertegn slik som «*» eller «?» er ikke støttet og vil ikke ha noen virkning. </p>
<p>Dessuten kan du skrive inn IP-adresser, f.eks. 1270.0.1 og IP-adresser med subnet, f.eks. 192.168..1/24</p>
</qt> <qt>
Kryss av her hvis du vil at mellomtjenerinnstillingene bare skal brukes  for oppføringene i <i>unntakslista</i></qt>. <qt>
Skriv inn den URI-en som skal brukes til å gjøre et søk i søkemotoren her.<br/>
Hele teksten det skal søkes etter kan oppgis som \{@} eller \{0}.<br/>
\{@} er anbefalt, siden da fjernes alle spørrevariabler (navn=verdi) fra resultatstrengen, mens \{0} blir erstattet med den uforandrede søkestrengen.<br/>Du kan bruke \{1} … \{n} til å oppgi bestemte ord fra spørringen og \{navn} til å oppgi en verdi gitt ved «navn=verdi» i brukerspørringen.<br/>Dessuten er det mulig å oppgi flere referanser (navn, tall og strenger) samtidig (\{navn1,navn2,.."streng"}).<br/>Den første verdien (fra venstre) som passer vil bli brukt som erstatningsverdi i den URI-en som blir resultatet.<br/>En streng i hermetegn kan brukes som standardverdi dersom ingenting passer fra venstre side i referanselista.
</qt> <qt>Skriv inn navnet på miljøvariabelen, f.eks. <b>NO_PROXY</b>, som brukes for å lagre adresser til steder der mellomtjener ikke skal brukes.<p>
Du kan også trykke på <b>Finn automatisk</b>for å forsøke å finne variabelen automatisk.
</qt> <qt>
Skriv inn navnet på miljøvariabelen som brukes for å lagre adressen til FTP mellomtjener, f.eks. <b>FTP_PROXY</b><p>
Du kan også trykke på <b>Finn automatisk</b> for å forsøke å finne variabelen automatisk.</p> 
</qt> <qt>
Skriv navnet på miljøvariabelen som brukes til å lagre adressen til HTTPS-mellomtjener, f.eks. <b>HTTPS_PROXY</b><p>
Du kan også trykke på <b>Finn automatisk</b>for å forsøke å finne variabelen automatisk.</p> 
</qt> <qt>
Skriv navnet på miljøvariabelen som brukes til å lagre adressen til HTTP-mellomtjener, f.eks. <b>HTTP_PROXY</b><p>
Du kan også trykke på <b>Finn automatisk</b>for å forsøke å finne variabelen automatisk.</p> 
</qt> <qt>
Skriv navnet på miljøvariabelen som brukes til å lagre adressen til SOCKS-mellomtjener, f.eks. <b>SOCKS_PROXY</b><p>
Du kan også trykke på <b>Finn automatisk</b>for å forsøke å finne variabelen automatisk.</p> 
</qt> <qt>
Velg søkemotor som skal brukes for tekstfelter som gir automatisk oppslag når du taster inn vanlig tekst i stedet for en URL.  Velg <b>Ingen</b> fra lista for å slå av denne effekten.
 </qt> <qt>
Tilpass mellomtjeneroppsett.
<p>
En mellomtjener er en datamaskin som sitter mellom ditt interne nettverk og Internett og tilbyr tjenester som mellomlagring og filtrering. Mellomlagring gir raskere tilgang til stedene du allerede har besøkt siden de lagres lokalt på mellomtjeneren din. Filtrerende mellomtjenere kan vanligvis blokkere sprettoppannonser, søppelpost eller annet du vil ha stengt ute.
<p>
Hvis du er usikker på om du trenger en mellomtjener for å koble deg til Internett, sjekk oppsettet til Internett-tilbyderen din, eller systemadministratoren.
</qt> <qt> <p>Bruk mellomtjenerinnstillingene definert på systemet.</p> 
<p>På noen plattformer settes det opp mellomtjeneroppsett for hele systemet, og om du velger dette kan du bruke de innstillingene.</p> 
<p>På Mac-plattformer</p> 
<p>På Windows-plattformer</p> 
<p>På Unix og Linux-plattformer er slike systeminnstillinger som regel definert ved miljøvariabler. Følgende miljøvariabler oppdages og brukes hvis de er til stede: <b>HTTP_PROXY</b>, <b>HTTPS_PROXY</b>, <b>FTP_PROXY</b> og <b>NO_PROXY</b>.</p> 
</qt> <qt>Forsøk å finne de miljøvariablene som brukes til å sette opp mellomtjenerinformasjon for hele dette systemet automatisk.<p>  Funksjonen virker ved å se etter disse vanlige variabelnavnene: HTTP_PROXY, FTP_PROXY and NO_PROXY.</qt> <para>Kryss av her for å begrense papirkurven til så mye diskplass som du oppgir nedenfor. Ellers blir den ubegrenset.</para> <para>Når KDEs søppelbøtte tømmes blir bare det som er slettet i KDE<br> fjernet, mens hvis Trash tømmes gjennom Finder blir alt slettet,</para> <para>Det som er slettet i KDE synes i mappa KDE.trash, inne i Trash-bøtta.</para> <para>Angi antall dager filer kan ligge i papirkurven. Filer som er eldre enn dette vil bli slettet akutomatisk.</para> <para>Dette er den beregnede del av diskplassen som kan brukes til papirkurven, maksimalt.</para> <para>Dette er høyeste prosent av diskplassen som kan brukes til papirkurven.</para> <para>Når grensen for størrelse er nådd vil systemet foretrekke å slette den typen fil du oppgir her. Hvis du velger å bli varslet, så vil systemet varsle deg i stedet for å slette filer automatisk.</para> Standard Foretrukket Oppdatering mislyktes Finn &automatisk Velg skilletegnet som står mellom nøkkelordet og setningen eller ordet det skal søkes etter. Kolon Koble direkte til Internett. S&lett Slå av passiv FTP Bruk &passiv-modus (PASV) Slår på «passiv» modus for FTP. Dette er nødvendig for at FTP skal kunne virke når den har en brannvegg foran seg. Skriv inn adressen til skriptet for mellomtjeneroppsett. Skriv adressen til FTP-mellomtjeneren her. Skriv adressen til HTTP-mellomtjeneren her. Skriv adressen til HTTPS-mellomtjeneren her. Skriv adressen til SOCKS-mellomtjeneren her. Oppgi det vanlige navnet på søkemotoren her. Skriv portnummeret til FTP-mellomtjeneren her. Skriv portnummeret til HTTP-mellomtjeneren her. Skriv portnummeret til HTTP-mellomtjeneren her. Skriv portnummeret til SOCKS-mellomtjeneren her. Unntak: FTP-innstiillinger Sett inn spørringsplassholder Ta vare på den Avgrens til Skriv inn oppsettsinformasjonen for mellomtjeneren manuelt. Merk av &delvis overførte filer Marker delvis opplastede filer Port: Søke&filtre Velg tegnsettet som blir brukt for koding av søkespørringen Velg tegnsettet som blir brukt for koding av søkespørringen. Vis &verdiene til miljøvariablene Størrelse: Mellomrom Bruk manuelt mellomtjeneroppsett Bruk det valgte oppsettsskriptet for å tilpasse innstillingene til mellomtjeneren. Bruk denne mellomtjeneren for &alle protokoller Når FTP-tilkoblinger er passive er det klienten som kobler til tjeneren, i stedet for omvendt, slik at brannmurer ikke blokkerer forbindelsen, men det kan være at gamle FTP-tjenere ikke støtter Passiv FTP. Mens en fil blir overført har den etternavnet «.part». Når overføringen er fullført, blir navnet omgjort til det virkelige navnet. Du må starte programmene på nytt for at disse endringene skal tre i kraft. 