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

{{- define "filebrowser-quantum.selectorLabels" -}}
app.kubernetes.io/name: {{ include "filebrowser-quantum.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}