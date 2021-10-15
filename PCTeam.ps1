Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object System.Windows.Forms.Form
$form.Text = "Some form"
$form.Size = New-Object System.Drawing.Size(150, 145)
$form.AutoSize = $true

$lbl1 = New-Object System.Windows.Forms.Label
$lbl1.Text = "Hello PC GEEK TEAM BY PCTECH  GR EU NEAPOLI LAKONIAS TEAM!"
$lbl1.Location = New-Object System.Drawing.Point(30, 20);

$lbl1.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Hey!")
})

$btn = New-Object System.Windows.Forms.Button
$btn.Text = "OK!!"
$btn.location = New-Object System.Drawing.Point(30, 60);
$btn.DialogResult = [System.Windows.Forms.DialogResult]::OK

$form.AcceptButton = $btn
$form.controls.Add($lbl1)
$form.controls.Add($btn)

$Null = $form.ShowDialog()
