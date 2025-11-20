# filebrowser-quantum-chart
Helm chart for the filebrowser-quantum 

This Helm chart provides a centralized solution to access multiple PVCs from a single deployment. I chose filebrowser-quantum because its dynamic indexing feature is essential for this use case.

## Liability Disclaimer

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

## Install

helm install myrelease ./mychart \
  --namespace my-namespace \
  --create-namespace

## Values

### Global
| Value | Default | Description |
|-------|---------|-------------|
| replicaCount | 1 | Number of replicas - do not change it, filebrowser does not support scaling so far |
| resources | {} | Optional CPU/memory requests and limits for the pod |

### Image
| Value | Default | Description |
|-------|---------|-------------|
| image.repository | gtstef/filebrowser | Docker image repository |
| image.tag | 1.0.3-stable | Docker image tag |
| image.pullPolicy | IfNotPresent | Image pull policy |

### Security Context
| Value | Default | Description |
|-------|---------|-------------|
| securityContext.enabled | true | Enable security context |
| securityContext.runAsUser | 1000 | User ID to run as |
| securityContext.runAsGroup | 1000 | Group ID to run as |
| securityContext.fsGroup | 1000 | File system group ID |
| securityContext.allowPrivilegeEscalation | false | Allow privilege escalation |

### Ingress
| Value | Default | Description |
|-------|---------|-------------|
| ingress.enabled | false | Enable ingress |
| ingress.tls | false | Enable TLS |
| ingress.host | "" | Hostname for the ingress |
| ingress.ingressClassName | "" | Ingress class name |
| ingress.annotations | {} | Annotations for the ingress |

### Service
| Value | Default | Description |
|-------|---------|-------------|
| service.port | 80 | Service port |

### Volumes
| Value | Default | Description |
|-------|---------|-------------|
| volumes.database.enabled | false | Enable database volume |
| volumes.database.storageClassName | "" | Storage class name |
| volumes.database.size | "" | Volume size |
| volumes.database.accessMode | ReadWriteOnce | Access mode |
| volumes.cache.enabled | false | Enable cache volume |
| volumes.cache.storageClassName | "" | Storage class name |
| volumes.cache.size | "" | Volume size |
| volumes.cache.maxArchiveSizeGB | "" | Maximum archive size in GB |
| volumes.cache.accessMode | ReadWriteOnce | Access mode |

### Data Volumes
| Value | Default | Description |
|-------|---------|-------------|
| dataVolumes | {} | Additional data volumes configuration |

### Config
| Value | Default | Description |
|-------|---------|-------------|
| config.customConfig | {} | Custom filebrowser configuration YAML (see comments for example format) |
| config.minSearchLength | 3 | Minimum search length |
| config.disableUpdateCheck | true | Disable update check |
| config.numImageProcessors | 4 | Number of image processors |
| config.socket | "" | Socket path |
| config.tlsKey | "" | TLS key file path |
| config.tlsCert | "" | TLS certificate file path |
| config.disablePreviews | false | Disable previews |
| config.disablePreviewResize | false | Disable preview resize |
| config.disableTypeDetectionByHeader | false | Disable type detection by header |
| config.baseURL | "/" | Base URL path |

#### Logging
| Value | Default | Description |
|-------|---------|-------------|
| config.logging.levels | "info" | Log levels |
| config.logging.apiLevels | "info" | API log levels |
| config.logging.output | "stdout" | Output destination |
| config.logging.noColors | true | Disable colors in logs |
| config.logging.json | false | Enable JSON logging |
| config.logging.utc | false | Use UTC time |

#### Filesystem
| Value | Default | Description |
|-------|---------|-------------|
| config.filesystem.createFilePermission | "644" | Permission for new files |
| config.filesystem.createDirectoryPermission | "755" | Permission for new directories |

#### Authentication
| Value | Default | Description |
|-------|---------|-------------|
| config.auth.tokenExpirationHours | 2 | Token expiration in hours |
| config.auth.methods.proxy.enabled | false | Enable proxy auth method |
| config.auth.methods.proxy.createUser | false | Create user from proxy |
| config.auth.methods.proxy.header | "" | Proxy header name |
| config.auth.methods.proxy.logoutRedirectUrl | "" | Logout redirect URL for proxy |
| config.auth.methods.noauth | false | Enable no-auth method |
| config.auth.methods.password.enabled | true | Enable password auth method |
| config.auth.methods.password.minLength | 5 | Minimum password length |
| config.auth.methods.password.signup | false | Allow user signup |
| config.auth.methods.password.recaptcha.host | "" | ReCAPTCHA host |
| config.auth.methods.password.recaptcha.recaptchaSecretName | "" | ReCAPTCHA secret name |
| config.auth.methods.password.recaptcha.key | "" | ReCAPTCHA site key |
| config.auth.methods.password.recaptcha.secret | "" | ReCAPTCHA secret key |
| config.auth.methods.password.enforcedOtp | false | Enforce OTP |
| config.auth.methods.oidc.enabled | false | Enable OIDC auth method |
| config.auth.methods.oidc.clientId | "" | OIDC client ID |
| config.auth.methods.oidc.clientSecret | "" | OIDC client secret |
| config.auth.methods.oidc.clientSecretName | "" | OIDC client secret name |
| config.auth.methods.oidc.issuerUrl | "" | OIDC issuer URL |
| config.auth.methods.oidc.scopes | "openid email profile" | OIDC scopes |
| config.auth.methods.oidc.userIdentifier | "preferred_username" | User identifier claim |
| config.auth.methods.oidc.disableVerifyTLS | false | Disable TLS verification |
| config.auth.methods.oidc.logoutRedirectUrl | "" | Logout redirect URL for OIDC |
| config.auth.methods.oidc.createUser | false | Create user from OIDC |
| config.auth.methods.oidc.adminGroup | "" | Admin group name |
| config.auth.methods.oidc.groupsClaim | "groups" | Groups claim name |
| config.auth.key | "" | Authentication key |
| config.auth.adminUsername | "admin" | Admin username |
| config.auth.adminPassword | "" | Admin password (ignored when `adminPasswordSecretName` is set) |
| config.auth.adminPasswordSecretName | "" | Name of a Secret containing key `password` for the admin password |
| config.auth.totpSecret | "" | TOTP secret |

#### User Defaults
| Value | Default | Description |
|-------|---------|-------------|
| config.userDefaults.editorQuickSave | false | Quick save in editor |
| config.userDefaults.hideSidebarFileActions | false | Hide sidebar file actions |
| config.userDefaults.disableQuickToggles | false | Disable quick toggles |
| config.userDefaults.disableSearchOptions | false | Disable search options |
| config.userDefaults.stickySidebar | false | Make sidebar sticky |
| config.userDefaults.darkMode | true | Enable dark mode |
| config.userDefaults.locale | "en" | Locale setting |
| config.userDefaults.viewMode | "normal" | View mode |
| config.userDefaults.singleClick | false | Single click to open files |
| config.userDefaults.showHidden | false | Show hidden files |
| config.userDefaults.dateFormat | false | Use date format |
| config.userDefaults.gallerySize | 3 | Gallery size |
| config.userDefaults.themeColor | "var(--blue)" | Theme color |
| config.userDefaults.quickDownload | false | Enable quick download |
| config.userDefaults.disablePreviewExt | "" | Disabled preview extensions |
| config.userDefaults.disableViewingExt | "" | Disabled viewing extensions |
| config.userDefaults.lockPassword | false | Lock password |
| config.userDefaults.disableSettings | false | Disable settings access |

##### Preview Settings
| Value | Default | Description |
|-------|---------|-------------|
| config.userDefaults.preview.disableHideSidebar | false | Disable hiding sidebar in preview |
| config.userDefaults.preview.highQuality | false | Enable high quality previews |
| config.userDefaults.preview.image | false | Enable image previews |
| config.userDefaults.preview.video | false | Enable video previews |
| config.userDefaults.preview.motionVideoPreview | false | Enable motion video preview |
| config.userDefaults.preview.office | false | Enable office document previews |
| config.userDefaults.preview.popup | false | Show previews in popups |
| config.userDefaults.preview.autoplayMedia | false | Autoplay media files |
| config.userDefaults.preview.defaultMediaPlayer | false | Default media player |
| config.userDefaults.preview.folder | false | Enable folder previews |

##### Permissions
| Value | Default | Description |
|-------|---------|-------------|
| config.userDefaults.permissions.api | false | API access permission |
| config.userDefaults.permissions.admin | false | Admin permission |
| config.userDefaults.permissions.modify | false | Modify permission |
| config.userDefaults.permissions.share | false | Share permission |
| config.userDefaults.permissions.realtime | false | Real-time permission |
| config.userDefaults.permissions.delete | false | Delete permission |
| config.userDefaults.permissions.create | false | Create permission |
| config.userDefaults.permissions.download | false | Download permission |

| Value | Default | Description |
|-------|---------|-------------|
| config.userDefaults.loginMethod | "password" | Default login method |
| config.userDefaults.disableUpdateNotifications | false | Disable update notifications |
| config.userDefaults.deleteWithoutConfirming | false | Delete without confirmation |
| config.userDefaults.fileLoading.maxConcurrentUpload | 10 | Maximum concurrent uploads |
| config.userDefaults.fileLoading.uploadChunkSizeMb | 10 | Upload chunk size in MB |
| config.userDefaults.fileLoading.clearAll | false | Clear all uploads |
| config.userDefaults.disableOnlyOfficeExt | ".md .txt .pdf" | Disabled OnlyOffice extensions |
| config.userDefaults.customTheme | "" | Custom theme CSS |
| config.userDefaults.showSelectMultiple | false | Show multiple selection |
| config.userDefaults.debugOffice | false | Enable OnlyOffice debug mode |
| config.userDefaults.defaultLandingPage | "" | Default landing page |

## Development

### Testing
Install the helm-unittest plugin:
```bash
helm plugin install https://github.com/helm-unittest/helm-unittest.git
```

Run all tests:
```bash
helm unittest ./filebrowser-quantum/
```

Run a specific test-suite:
```bash
helm unittest ./filebrowser-quantum/tests/storage_standard_volumes_deployment_test.yaml
```

### Linting
Lint the Helm chart files:
```bash
helm lint ./filewbrower-quantum/
```

### Template Rendering
Render templates to stdout for review:
```bash
helm template ./filebrowser-quantum/
``` 