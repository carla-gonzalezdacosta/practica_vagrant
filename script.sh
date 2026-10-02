# Actualizar e instalar apache
apt-get update
apt-get install -y apache2

# Habilitarlo para arrancar
systemctl enable apache2
systemctl start apache2

# Crear la página de inicio con mi nombre y hostname
echo "Servidor de Carla - Hostname: $(hostname)" > /var/www/html/index.html