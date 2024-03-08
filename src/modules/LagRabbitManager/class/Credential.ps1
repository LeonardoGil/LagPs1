class Credential {
    [string]$url
    [string]$username
    [string]$password

    [string] BasicToken() {
        $code = [string]::Concat($this.username, ':', $this.password)
        return [Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($code));
    }

    [System.Collections.Hashtable] GetHeader() {
        $base64 = $this.BasicToken()
        return @{ Authorization = "Basic $base64" }
    }
}