��          �   %   �      @     A  �   H      s    �   �     n  !   �     �     �     �  Z   �  5   ?  *   u  +   �  ,   �     �  6   	     <	     [	  ,   y	     �	  �   �	  l   n
  N   �
  !  *     L  �   T  /    �  J  �   �     �     �  	   �       !     Y   A  "   �     �  (   �  )        1  @   D  (   �  '   �  )   �  
      �     t   �  E   2                                                                                 
            	                                 &Name: <p>Marks partially uploaded FTP files.</p><p>When this option is enabled, partially uploaded files will have a ".part" extension. This extension will be removed once the transfer is complete.</p> <qt>
Enter the environment variable, e.g. <b>NO_PROXY</b>, used to store the addresses of sites for which the proxy server should not be used.<p>
Alternatively, you can click on the <b>"Auto Detect"</b> button to attempt an automatic discovery of this variable.
</qt> <qt>
Setup proxy configuration.
<p>
A proxy server is an intermediate machine that sits between your computer and the Internet and provides services such as web page caching and filtering. Caching proxy servers give you faster access to web sites you have already visited by locally storing or caching those pages; filtering proxy servers usually provide the ability to block out requests for ads, spam, or anything else you want to block.
<p>
If you are uncertain whether or not you need to use a proxy server to connect to the Internet, consult your Internet service provider's setup guide or your system administrator.
</qt> <qt>Attempt automatic discovery of the environment variables used for setting system wide proxy information.<p> This feature works by searching for commonly used variable names such as HTTP_PROXY, FTP_PROXY and NO_PROXY.</qt> @title:windowUpdate Failed Connect to the Internet directly. De&lete Disable Passive FTP Enable passive &mode (PASV) Enables FTP's "passive" mode. This is required to allow FTP to work from behind firewalls. Enter the address for the proxy configuration script. Enter the address of the FTP proxy server. Enter the address of the HTTP proxy server. Enter the address of the HTTPS proxy server. FTP Options Manually enter proxy server configuration information. Mark &partially uploaded files Mark partially uploaded files Show the &value of the environment variables Size: When FTP connections are passive the client connects to the server, instead of the other way round, so firewalls do not block the connection; old FTP servers may not support Passive FTP though. While a file is being uploaded its extension is ".part". When fully uploaded it is renamed to its real name. You have to restart the running applications for these changes to take effect. Project-Id-Version: kcmkio 0
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2011-07-18 11:46+0200
Last-Translator: Marko Dimjašević <marko@dimjasevic.net>
Language-Team: Croatian <kde-croatia-list@lists.sourceforge.net>
Language: hr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);
X-Generator: Lokalize 1.2
X-Environment: kde
X-Accelerator-Marker: &
X-Text-Markup: kde4
 &Naziv: <p>Označi djelomično uploadane FTP datoteke</p> <p>Ako je ova opcija omogućena, djelomično uploadane datoteke će imati ekstenziju ".part". Ekstenzija će biti maknuta kad prijenos završi.</p> <qt>
Unesite ime varijable okoline, npr. <b>NO_PROXY</b>, koja će se koristiti za spremanje adrese web stranica za koje neće biti korišten posrednički poslužitelj. <p>
Alternativno, možete kliknuti na gumb <b>"Automatsko otkrivanje"</b> da biste pokrenuli automatsko otkrivanje te varijable.
</qt> <qt>
Podešavanje poslužitelja-posrednika.
<p>
Poslužitelj-posrednik je posredovno računalo koje stoji između Vašeg računala i Interneta, te pruža usluge poput predmemoriranja web stranica ili filtriranja. Poslužitelji-posrednici za predmemoriranje Vam omogućuju brži pristup već posjećenim web stranicama tako da ih lokalno spremi ili predmemorira; filtrirajući poslužitelji-posrednici obično omogućuju blokiranje reklama ili bilo čega što Vas nervira.
<p>
Ako niste sigurni treba li vam poslužitelj-posrednik za pristup Internetu, provjerite upute vašeg pružatelja Internet usluga ili potražite savjet vašeg upravitelja sustava.
</qt> <qt>Pokušaj automatskog otkrivanja varijabli okoline koje se koriste za postavljanje sustavskih informacija o posrednicima. <p>Ova mogućnost radi za pretragu često korištenih varijabli poput HTTP_PROXY, FTP_PROXY i NO_PROXY.</qt> Neuspjelo ažuriranje Izravno povezivanje na Internet &Izbriši Onemogući pasivni FTP Onemogući pasivni &način (PASV) Omogući FTP passive mode. Ovo je potrebno da bi koristili FTP iza vatrozida (firewalla). Unesite adresu HTTP proxy skripte. Unesite adresu FTP posrednika.. Unesite adresu HTTP proxy poslužitelja. Unesite adresu HTTPS proxy poslužitelja. Podešavanje FTP-a Ručno unesite podatke za podešavanje poslužitelja-posrednika. Označi &djelomično uploadane datoteke. Označi djelomično uploadane datoteke. Prikaži &vrijednosti okolišni varijabli Veličina: Kada su FTP veze pasivne, klijent se povezuje na poslužitelj, umjesto obrnuto, tako da vatrozidi ne blokiraju vezu; stariji FTP poslužitelji možda ne podržavaju pasivni FTP. Dok se datoteka uploada njezina ekstenzija je ".part". Kad upload završi, datoteka se preimenuje u njeno pravo ime. Morate restartati pokrenute programe da bi ove izmjene bile vidljive. 