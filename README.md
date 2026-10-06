\#!/bin/bash



\# Practica de Investigación: primeros pasos con Vagrant



\## ASIR2/IWEB - Carla González Da Costa



\### 02/10/2026



\#### Parte A: Investigación y Conceptos



1. Vagrant y Vagrantfile



Vagrant es una herramienta que sirve para automatizar las configuraciones de las máquinas virtuales, es decir, en vez de cada vez que quieras crear una VM tener que configurar RAM, CPU, red, sistema operativo, etc, todo esto se define en un archivo llamado Vagrantfile y solamente con hacer un up (vagrant up) de ese archivo, automáticamente se configura la máquina virtual, por lo que se pueden crear VM con las mismas configuraciones de forma rápida y automática, sin tener que ir configurándolas una por una.



Distinguir los diferentes conceptos:



* Anfitrión: Es el ordenador físico con el que se está trabajando y donde se van a crear las VMs, es decir, el host.



* Proveedor de virtualización: Es el software a partir del cuál vamos a crear las máquinas virtuales, como VirtualBox o VMware.



* Box: Es la imagen base que utiliza Vagrant para crear una máquina virtual. Por ejemplo, una box de Ubuntu.



* Máquina virtual (VM): Es la máquina que se crea en el anfitrión por el proveedor de virtualización.



Vagrant está escrito en Ruby.



Del archivo inicial he añadido estas líneas de comando para poder tener una red privada con IP estática, añadir el hostname y configurar el archivo script.sh, donde más tarde he añadido un provisionamiento.

config.vm.hostname = "servidor-tu-nombre"

&#x20; config.vm.network "forwarded\_port", guest: 80, host: 8080, host\_ip: "127.0.0.1"

&#x20; config.vm.network "private\_network", ip: "192.168.56.10"

&#x20; config.vm.provision "shell", path: "script.sh"





2\. Aprovisionamiento



Un provisioner es el mecanismo que usa Vagrant para configurar automáticamente una máquina virtual después de crearla. Por ejemplo, puedes decirle a Vagrant que después de crear la VM, instale Apache, por lo tanto, lo hará.



El script se ejecuta dentro de la máquina virtual, es por eso que podrá instalar apache, ya que el comando sudo apt install apache2, se va a ejecutar en la máquina. Además, se lanza cuando ejecutamos el comando vagrant up, Vagrant va a crear e iniciar la máquina y luego va a ejecutar el provisionamiento.



Existen dos formas de indicar el script: inline y path.



* inline: el script se escribe dentro del vagrantfile.
* 
* path: el script está escrito dentro de un archivo diferente a vagrantfile, pero ese archivo está en la misma carpeta que vagrantfile.



Si modificamos el archivo vagrantfile después de haber hecho un vagrant up, la modificación no se va a ejecutar automáticamente, solamente por guardar ese archivo.

Debemos ejecutar el comando ‘vagrant provision’ para que haga el cambio del aprovisionamiento que hemos añadido al vagrantfile.



3\. Interfaces y redes



Por defecto, Vagrant utiliza una red NAT y la utiliza para que la VM tenga acceso a Internet utilizando la conexión del host.



En vagrantfile podemos añadir una segunda interfaz utilizando una red privada. Deberíamos añadir al archivo esta línea de comandos: config.vm.network "private\_network", ip: "192.168.56.10" . En este caso, le hemos asignado como IP fija 192.168.56.10



| Tipo | ¿Con quién puede comunicarse? | Función |

| --- | --- | --- |

| Red NAT | Internet y servicios mediante el anfitrión | Dar Internet a la VM |

| Red interna | Con otras máquinas conectadas a esa misma red interna | Crear una red aislada entre vms |

| host-only | Anfitrión y otras máquinas en la misma red privada | host <-> vm |

| Red pública | Con máquinas de la red física a la que está conectada el host | La vm aparecerá como un equipo de la red |





La red interna solo permite comunicación entre VMs que estén conectadas a la misma red. La red Host-Only, en cambio, permite comunicación entre las VMs y el anfitrión.



Añadir la segunda interfaz no elimina la NAT ya que cada una se configura en una interfaz diferente. Por otro lado, el reenvío de puertos no crea ninguna interfaz de red adicional. Es simplemente una regla de redirección de tráfico.





* eth0: Es la interfaz NAT y recibe una IP por DHCP. Es la interfaz por defecto y la que permite que la VM navegue por Internet.



* eth1: Es la red privada y le he asignado una IP estática 192.168.56.10.

\[Esquema de la arquitectura](image\_vagrant/esquema.png)



4\. Órdenes y carpeta compartida



\[Tabla](image\_vagrant/tabla.png)





\#### Parte B: Mi primera máquina en Vagrant



\[Conexión ssh](image\_vagrant/ssh.png)



\#### Parte C: Completa el vagrantfile



Una vez alterado el archivo vagrantfile con la información que me da el apartado C, entro por ssh en la vm y compruebo las interfaces de red y el hostname.



\[Imagen interfaces](image\_vagrant/ip\_a\_nat\_interna.png)



\#### Parte D: Aprovisiona Apache



Después de haber creado contenido en el archivo script.sh, creado anteriormente, donde hemos dicho que debe instalar apache, activarlo cuando inice y escribir una página de inicio sencilla. Con el comando vagrant provision le hemos dicho a la máquina que hemos modificado el aprovisionamiento, y debe volver a ejecutarlo para conocer las actualizaciones.



\[Imagen comprobación navegador](image\_vagrant/captura\_navegador.png)



\[Imagen apache activo](image\_vagrant/apache\_activo.png)







Finalmente, he podido realizar correctamente está práctica y me ha servido para aprender más sobre la herramienta Vagrant, la cual me parece muy útil a la hora de configurar automáticamente máquinas virtuales.

