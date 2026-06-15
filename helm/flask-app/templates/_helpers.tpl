{{- define "flask-app.name" -}}
flask-app
{{- end }}

{{- define "flask-app.fullname" -}}
{{ include "flask-app.name" . }}
{{- end }}

{{- define "flask-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{ default (include "flask-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
default
{{- end }}
{{- end }}
