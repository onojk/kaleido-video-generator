��          �      l      �  G   �  _   )  1   �  >   �  �   �  �  �     @      T  /   u  3   �  =   �       C   1  (   u  �   �  a   M  (   �  p   �  %   I	  �  o	  H  '  g   p  ?   �  O     T   h  !   �  �  �  .   �  I     >   O  b   �  �   �  3   {  h   �  K       d  �   }  P   0  E   �  =   �  �                 
                                      	                                             
Make sure that the samba package is installed properly on your system. %1 is an error number, %2 either a pretty string or the numberUnknown error condition: [%1] %2 %1:
Unknown file type, neither directory or file. <qt>Please enter authentication information for <b>%1</b></qt> @info:status smb failed to reach the server (e.g. server offline or network failure). %1 is an ip address or hostname%1: Host unreachable @info:whatsthis<para>There are various options for authenticating on SMB shares.</para><para><placeholder>username</placeholder>: When authenticating within a home network the username on the server is sufficient</para><para><placeholder>username@domain.com</placeholder>: Modern corporate logon names are formed like e-mail addresses</para><para><placeholder>DOMAIN\username</placeholder>: For ancient corporate networks or workgroups you may need to prefix the NetBIOS domain name (pre-Windows 2000)</para><para><placeholder>anonymous</placeholder>: Anonymous logins can be attempted using empty username and password. Depending on server configuration non-empty usernames may be required</para> Bad file descriptor Could not connect to host for %1 Error occurred while trying to access %1<nl/>%2 Error while connecting to server responsible for %1 Mounting of share "%1" from host "%2" by user "%3" failed.
%4 No media in device for %1 Please enter authentication information for:
Server = %1
Share = %2 Share could not be found on given server The given name could not be resolved to a unique server. Make sure your network is setup without any name conflicts between names used by Windows and by UNIX name resolution. Unable to find any workgroups in your local network. This might be caused by an enabled firewall. Unmounting of mountpoint "%1" failed.
%2 host entry when no pretty name is available. %1 likely is an IP addressUnknown Device @ <resource>%1</resource> libsmbclient failed to create context libsmbclient reported an error, but did not specify what the problem is. This might indicate a severe problem with your network - but also might indicate a problem with libsmbclient.
If you want to help us, please provide a tcpdump of the network interface while you try to browse (be aware that it might contain private data, so do not post it if you are unsure about that - you can send it privately to the developers if they ask for it) Project-Id-Version: kio_smb
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2021-08-28 22:23+0300
Last-Translator: Alexander Yavorsky <kekcuha@gmail.com>
Language-Team: Russian <kde-russian@lists.kde.ru>
Language: ru
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Lokalize 21.08.0
Plural-Forms: nplurals=4; plural=n==1 ? 3 : n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2;
n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);
X-Environment: kde
X-Accelerator-Marker: &
X-Text-Markup: kde4
 
Убедитесь, что пакет samba правильно установлен в системе. Неизвестное состояние ошибки: [%1] %2 %1:
Неизвестный тип файла: ни папка и ни файл. <qt>Укажите сведения идентификации для <b>%1</b></qt> %1: Хост недоступен <para>Возможны несколько способов прохождения аутентификации при подключении совместно используемых ресурсов SMB:</para>
<para><placeholder>имя пользователя</placeholder>: При прохождении аутентификации при подключении внутри домашней сети достаточно указать существующее на сервере имя пользователя.</para> <para><placeholder>имя пользователя@домен</placeholder>: Современные корпоративные имена пользователя для входа в систему похожи на адреса электронной почты.</para> <para><placeholder>ДОМЕН\имя пользователя</placeholder>: Для входа в устаревшие корпоративные сети или рабочие группы может потребоваться указание домена NetBIOS (используется в системах, предшествующих Windows 2000)</para> <para><placeholder>анонимно</placeholder>: Анонимный вход в систему подразумевает пустое имя пользователя и пароль. В зависимости от параметров сервера может потребоваться указать непустое имя пользователя.</para> Неверный описатель файла Невозможно подключиться к серверу для %1 Не удалось получить доступ к %1<nl/>%2 Ошибка при подключении к серверу, ответственному за %1 Ошибка монтирования ресурса «%1» сервера «%2» под именем пользователя «%3».
%4 Нет диска в устройстве для %1 Укажите информацию идентификации для:
Сервер = %1
Папка = %2 Невозможно найти папку на данном сервере Указанное имя не может быть преобразовано в уникальный адрес сервера. Убедитесь, что в вашей сети нет конфликтов между именами, используемыми в Windows и UNIX. Невозможно найти рабочие группы в вашей локальной сети. Возможно, этому препятствует брандмауэр. Ошибка отключения точки монтирования «%1».
%2 Неизвестное устройство @ <resource>%1</resource> ошибка создания контекста libsmbclient Библиотека libsmbclient сообщила об ошибке, но не указала, в чём её причина. Это может быть связано с неполадкой сети или самой библиотеки.
Если вы хотите нам помочь, сообщите вывод команды tcpdump, сделанный во время попытки обзора сети (учтите, что вывод tcpdump может содержать секретные данные, поэтому не публикуйте его - вы можете отправить его разработчикам личной почтой, если они запросят) 