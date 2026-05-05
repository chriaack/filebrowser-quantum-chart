{{- define "filebrowser-quantum.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 56 | trimSuffix "-" -}}
{{- end -}}

{{- define "filebrowser-quantum.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 56 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 56 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "filebrowser-quantum.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 56 | trimSuffix "-" -}}
{{- end -}}

{{- define "filebrowser-quantum.labels" -}}
helm.sh/chart: {{ include "filebrowser-quantum.chart" . }}
{{- with .Chart.AppVersion }}
app.kubernetes.io/version: {{ . | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "filebrowser-quantum.selectorLabels" . }}
{{- end -}}

{{- define "filebrowser-quantum.adminSecretName" -}}
{{- if .Values.config.auth.adminPasswordSecretName }}
{{- .Values.config.auth.adminPasswordSecretName }}
{{- else }}
{{- printf "%s-admin-password" (include "filebrowser-quantum.fullname" .) }}
{{- end }}
{{- end }}

{{- define "filebrowser-quantum.oidcSecretName" -}}
{{- if .Values.config.auth.methods.oidc.clientSecretName }}
{{- .Values.config.auth.methods.oidc.clientSecretName }}
{{- else }}
{{- printf "%s-oidc-secret" (include "filebrowser-quantum.fullname" .) }}
{{- end }}
{{- end }}

{{- define "filebrowser-quantum.shouldCreateAdminSecret" -}}
{{- not .Values.config.auth.adminPasswordSecretName }}
{{- end }}

{{- define "filebrowser-quantum.shouldCreateOIDCSecret" -}}
{{- and (include "filebrowser-quantum.oidcEnabled" .) (not .Values.config.auth.methods.oidc.clientSecretName) }}
{{- end }}

{{- define "filebrowser-quantum.oidcEnabled" -}}
{{- if hasKey .Values.config.auth.methods "oidc" }}
{{- .Values.config.auth.methods.oidc.enabled }}
{{- else }}
{{- false }}
{{- end }}
{{- end }}

{{- define "filebrowser-quantum.selectorLabels" -}}
app.kubernetes.io/name: {{ include "filebrowser-quantum.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}