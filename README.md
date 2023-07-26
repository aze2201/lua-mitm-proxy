# Man in Middle implementation on OpenResty
## Description
This OpenResty-based MITM Proxy allows cybersecurity teams to investigate HTTPS traffic for security analysis and debugging purposes. It provides a platform to intercept and inspect encrypted HTTPS communication, aiding in the identification of potential security threats or vulnerabilities.

Project Goals:
- Intercept and inspect HTTPS traffic without terminating SSL/TLS connections.
- Facilitate security professionals in analyzing and understanding HTTPS communication.
- Enable the investigation of potential security threats or vulnerabilities.


[Wiki](https://github.com/aze2201/lua-mitm-proxy/wiki/MITM-in-NGINX-LUA=OpenResty)


## How it works.
MitM Proxy for HTTPS Traffic Analysis

The **Man-in-the-Middle** (MitM) Proxy is designed to intercept HTTPS traffic and facilitate investigation for security analysis and debugging purposes. When a user's browser resolves a domain to the host where the MitM Proxy is located, the proxy generates a new certificate pair for that host and forwards the request to the original destination. To find the requested original host, the proxy leverages Google Public DNS servers.

Please be aware that using a self-signed certificate for MitM results in browser warnings. To bypass these warnings, you can install the root CA file to your OS or Browser CA repository. Once successfully installed, you will find the root CA file under ./rootCA/global.crt, which you can then import into your browser.

Note: The installation process may vary across different platforms and operating systems.


Contributions and Feedback:
We encourage contributions and feedback from the community. Feel free to submit pull requests or raise issues on the project repository.

Disclaimer:
This MitM Proxy is intended solely for legitimate security research and analysis purposes. Unauthorized or malicious use is strictly prohibited.

Stay tuned for updates and improvements as we continue to enhance the project!



## Improvement Plans:
- Refactoring: I will gradually refactor the codebase to improve its structure, readability, and maintainability.
- Bug Fixes: I will actively address reported issues and fix bugs to enhance the project's stability.
- Feature Enhancements: I plan to add new features and functionalities to enhance the capabilities of the project.
- Code Optimization: I will optimize the code for better performance and efficiency.


## How to install

```
$ git clone git@github.com:aze2201/lua-mitm-proxy.git
$ cd lua-mitm-proxy
$ make build
$ # you can tag image to latest
$ make tag
```

```
# start container
docker-compose --env-file variables.env up
```


NOTE: 
- It runs on docker which uses isolated network by default. If browser in external machine you will need `docker --net=host`.
- If you reinstall project, certificate files will be re-newed and you will need to install again on browser.
- For testing purpose you can update OS to resolve single domain to this host and test it. (in linux machines **/etc/hosts** )

## Motivation
You can sponsor this project to speed up development and improvements.
### Contacts
Name: Fariz Muradov

Email: aze2201@gmail.com

Country: 🇦🇿

