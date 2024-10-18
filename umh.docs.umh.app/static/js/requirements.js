document.addEventListener('DOMContentLoaded', function() {
    async function fetchRequirements() {
      try {
        const response = await fetch('https://management.umh.app/requirements.json');
        
        // Check if the fetch was successful
        if (!response.ok) {
          throw new Error('Network response was not ok ' + response.statusText);
        }
        
        const data = await response.json();
  
        // Ensure that releases exist in the JSON
        if (!data.releases || data.releases.length === 0) {
          throw new Error('No releases found in the JSON data.');
        }
  
        // Function to compare version strings X.Y.Z
        function compareVersions(v1, v2) {
          const parts1 = v1.split('.').map(Number);
          const parts2 = v2.split('.').map(Number);
          for (let i = 0; i < Math.max(parts1.length, parts2.length); i++) {
            const num1 = parts1[i] || 0;
            const num2 = parts2[i] || 0;
            if (num1 > num2) return 1;
            if (num1 < num2) return -1;
          }
          return 0;
        }
  
        // Function to capitalize the first letter
        function capitalizeFirstLetter(string) {
          if (!string) return '';
          return string.charAt(0).toUpperCase() + string.slice(1);
        }
  
        // Function to format OS list into natural language
        function formatOSList(names) {
          if (names.length === 0) return '';
          if (names.length === 1) return names[0];
          if (names.length === 2) return `${names[0]} or ${names[1]}`;
          return names.slice(0, -1).join(', ') + ' or ' + names[names.length - 1];
        }
  
        // Find the release with the highest releaseVersion
        let latestRelease = data.releases[0];
        for (let i = 1; i < data.releases.length; i++) {
          if (compareVersions(data.releases[i].releaseVersion, latestRelease.releaseVersion) > 0) {
            latestRelease = data.releases[i];
          }
        }
  
        const releaseVersion = latestRelease.releaseVersion;
  
        // Create a list for system requirements
        const systemRequirements = [
          { name: 'CPU', value: latestRelease.systemRequirements.cpu.cores + ' Cores' },
          { name: 'Memory', value: (latestRelease.systemRequirements.memory.bytes / (1024 ** 3)).toFixed(2) + ' GB' },
          { name: 'Storage', value: (latestRelease.systemRequirements.disk.bytes / (1024 ** 3)).toFixed(2) + ' GB' }
        ].map(req => `<li><strong>${req.name}</strong>: ${req.value}</li>`).join('');
  
        // Inject system requirements into #requirements-2
        const requirementsDiv2 = document.getElementById('requirements-2');
        if (requirementsDiv2) {
          requirementsDiv2.innerHTML = `
            <ul>
              ${systemRequirements}
            </ul>
          `;
        } else {
          console.error('requirements-2 div not found');
        }
  
        // Process supported OS
        let supportedOS = latestRelease.supportedOS.map(os => {
          // Extract architectures, exclude ARM
          const architectures = os.supportedVersions
            .flatMap(v => v.architecture)
            .filter(arch => arch.toLowerCase() !== 'arm')
            .join(', ');
          
          // Extract versions and kernels
          const versions = os.supportedVersions.map(v => `${v.version} (Kernel: ${v.kernel})`).join(', ');
          
          return {
            name: os.name,
            versions: versions,
            architectures: architectures
          };
        });
  
        // Sort supportedOS to place Rocky at the top
        supportedOS = supportedOS.sort((a, b) => {
          if (a.name.toLowerCase() === 'rocky') return -1;
          if (b.name.toLowerCase() === 'rocky') return 1;
          return 0;
        });
  
        // Map to HTML, append "(recommended)" to Rocky
        const supportedOSHTML = supportedOS.map(os => {
          let osName = os.name 
            ? os.name.charAt(0).toUpperCase() + os.name.slice(1)
            : '';
          if (os.name.toLowerCase() === 'rocky') {
            osName += ' (recommended)';
          }
          return `<li><strong>${osName}:</strong>
            <ul>
              <li><strong>Architecture:</strong> ${os.architectures}</li>
              <li><strong>Versions:</strong> ${os.versions}</li>
            </ul>
          </li>`;
        }).join('');
  
        // Inject supported OS into #requirements-3
        const requirementsDiv3 = document.getElementById('requirements-3');
        if (requirementsDiv3) {
          requirementsDiv3.innerHTML = `
            <ul>
              ${supportedOSHTML}
            </ul>
          `;
        } else {
          console.error('requirements-3 div not found');
        }
  
        // **New Functionality: Inject OS List into #requirements-4**
        
        // Extract OS names from supportedOS
        const osNames = supportedOS.map(os => {
          return os.name.charAt(0).toUpperCase() + os.name.slice(1);
        });
  
        // Format the OS list into natural language (e.g., "Rocky, RHEL or Flatcar")
        const formattedOSList = formatOSList(osNames);
  
        // Inject the formatted OS list into #requirements-4
        const requirementsDiv4 = document.getElementById('requirements-4');
        if (requirementsDiv4) {
          requirementsDiv4.textContent = formattedOSList;
        } else {
          console.error('requirements-4 span not found');
        }
  
      } catch (error) {
        console.error('Error fetching JSON:', error);
        const requirementsDiv2 = document.getElementById('requirements-2');
        const requirementsDiv3 = document.getElementById('requirements-3');
        const requirementsDiv4 = document.getElementById('requirements-4');
        if (requirementsDiv2) {
          requirementsDiv2.innerHTML = '<p>Error loading system requirements.</p>';
        }
        if (requirementsDiv3) {
          requirementsDiv3.innerHTML = '<p>Error loading supported operating systems.</p>';
        }
        if (requirementsDiv4) {
          requirementsDiv4.textContent = 'Error loading supported operating systems.';
        }
      }
    }
  
    fetchRequirements();
  });
  