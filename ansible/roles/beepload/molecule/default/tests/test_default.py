import os
import testinfra.utils.ansible_runner

# Get test infrastructure runner
runner = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE'])

testinfra_hosts = runner.get_hosts('all')

def test_docker_installed(host):
    """Test if Docker is installed and running."""
    docker = host.package('docker-ce')
    assert docker.is_installed
    
    docker_service = host.service('docker')
    assert docker_service.is_running
    assert docker_service.is_enabled

def test_beeploy_directory(host):
    """Test if Beepload directory exists and has correct permissions."""
    dir_path = '/opt/beepload'
    directory = host.file(dir_path)
    
    assert directory.exists
    assert directory.is_directory
    assert directory.user == 'root'
    assert directory.group == 'root'
    assert directory.mode == 0o755

def test_docker_compose_file(host):
    """Test if docker-compose.yml exists."""
    compose_file = host.file('/opt/beepload/docker-compose.yml')
    assert compose_file.exists
    assert compose_file.is_file

def test_containers_running(host):
    """Test if all required containers are running."""
    # Get running containers
    cmd = host.run('docker ps --format "{{.Names}}"')
    assert cmd.rc == 0
    
    running_containers = cmd.stdout.split()
    expected_containers = [
        'caddy',
        'upload-service',
        'auth-service',
        'db'
    ]
    
    for container in expected_containers:
        assert any(container in c for c in running_containers), \
            f"Container {container} is not running"

def test_ports_listening(host):
    """Test if required ports are listening."""
    ports = [80, 443, 3000]
    
    for port in ports:
        # Using netstat to check listening ports
        cmd = host.run(f'netstat -tuln | grep ":{port}"')
        # If netstat command fails, try ss
        if cmd.rc != 0:
            cmd = host.run(f'ss -tuln | grep ":{port}"')
        
        assert cmd.rc == 0, f"Port {port} is not listening"
