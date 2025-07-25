��    &      L  5   |      P     Q  �   o  a  /  "   �  '   �  �   �     �  H   �     $  #   A  #   e  2   �  ,   �  $   �  )     &   8      _     �     �     �     �     �      	     	     1	     I	     i	     �	  %   �	     �	  (   �	  
   
     
     
  N   6
  5   �
  T   �
  I    *   Z  �   �  �  x  8   h  ?   �  n  �  9   P  �   �  Z   %  I   �  2   �  g   �  ]   e  b   �  a   &  E   �  S   �  E   "  6   h  ?   �  t   �  Z   T  U   �  ?     I   E  =   �  D   �  &     3   9     m  ?   �     �  	   �  +   �  �      l   �  L        	                                            %            &                      
       #               !          $                      "                                         @action:buttonConnect Anyway @info<para>The authenticity of host <emphasis>%1</emphasis> cannot be established.</para><para>The %2 key fingerprint is:<bcode>%3</bcode>Are you sure you want to continue connecting?</para> @info<para>The host key for the server <emphasis>%1</emphasis> has changed.</para><para>This could either mean that DNS spoofing is happening or the IP address for the host and its host key have changed at the same time.</para><para>The %2 key fingerprint sent by the remote host is:<bcode>%3</bcode>Are you sure you want to continue connecting?</para> @title:windowHost Identity Change @title:windowHost Verification Failure An %1 host key for this server was not found, but another type of key exists.
An attacker might change the default server key to confuse your client into thinking the key does not exist.
Please contact your system administrator.
%2 Authentication failed. Authentication failed. The server didn't send any authentication methods Could not allocate callbacks Could not change permissions for
%1 Could not create a new SSH session. Could not create fingerprint for server public key Could not create hash from server public key Could not disable Nagle's Algorithm. Could not get server public key type name Could not initialize the SFTP session. Could not parse the config file. Could not set a timeout. Could not set compression. Could not set host. Could not set log callback. Could not set log userdata. Could not set log verbosity. Could not set port. Could not set username. Incorrect or invalid passphrase Incorrect username or password Invalid sftp context Opening SFTP connection to host %1:%2 Please enter your password. Please enter your username and password. SFTP Login Site: Successfully connected to %1 Unable to request the SFTP subsystem. Make sure SFTP is enabled on the server. Use the username input field to answer this question. error message. %1 is a path, %2 is a numeric error codeCould not read link: %1 [%2] Project-Id-Version: kio_sftp
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2023-01-28 11:01+0300
Last-Translator: Alexander Yavorsky <kekcuha@gmail.com>
Language-Team: Russian <kde-russian@lists.kde.ru>
Language: ru
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Lokalize 21.08.3
Plural-Forms: nplurals=4; plural=n==1 ? 3 : n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2;
n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);
X-Environment: kde
X-Accelerator-Marker: &
X-Text-Markup: kde4
 Всё равно подключиться <para>Не удалось установить подлинность сервера <emphasis>%1</emphasis>.</para><para>Отпечаток ключа %2: <bcode>%3</bcode>Продолжить подключение к серверу?</para> <para>Изменён ключ сервера <emphasis>%1</emphasis>.</para><para>Это означает, что возможна подмена адреса сервера либо были одновременно были изменены изменены IP-адрес сервера и его ключ.</para> <para>Отпечаток ключа, полученный сейчас с сервера %2: <bcode>%3</bcode>Продолжить подключение к серверу?</para> Изменился идентификатор хоста Ошибка проверки подлинности хоста Для этого сервера не найден ключ узла %1, но присутствует другой тип ключа.
Подобную ситуацию может вызывать подмена ключа сервера атакующим злоумышленником.
Обратитесь к системному администратору.
%2 Проверка подлинности неудачна. Проверка подлинности неудачна. Сервер не передал список доступных методов проверки Не удалось выделить память под функции обработки Невозможно изменить права доступа для
%1 Не удалось открыть сеанс SSH. Не удалось создать отпечаток из открытого ключа сервера Не удалось получить хэш из открытого ключа сервера Не удалось отключить использование алгоритма Нейгла. Не удалось получить имя типа открытого ключа сервера Не удалось инициализировать сеанс SFTP. Не удалось обработать конфигурационный файл. Не удалось установить время ожидания. Не удалось установить сжатие. Не удалось установить имя сервера. Не удалось задать функцию обратного вызова для журналирования. Не удалось задать доп. данные для журналирования. Не удалось установить уровень журналирования. Не удалось установить номер порта. Не удалось установить имя пользователя. Неверный или некорректный пароль Неверное имя пользователя или пароль Неверный контекст sftp Подключение к SFTP-серверу %1:%2 Введите пароль. Введите имя пользователя и пароль. Вход на сервер SFTP Сайт: Успешное соединение с %1 Не удаётся использовать подсистему SFTP. Убедитесь, что сервер поддерживает SFTP. Введите ответ на этот вопрос в поле для имени пользователя. Не удалось прочитать ссылку «%1», ошибка: %2 