# ----------------------------------------------------
# -- Projet : Illustrate GUI Winforms functions for Powershell - Add Objects
# -- Author : Ronaf
# -- Created : 30/08/2024
# -- Update : 
# --  
# ----------------------------------------------------


#------ Init
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -scope currentuser
. "$PSScriptRoot\GUI_Winforms.ps1"
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

#------ Form - Init
$MyFormParam = @{
    text = "My Form Title"
    Width = 0
    Height = 0
    BackColor = 'LightBlue'
}
$Form = New-FormLight @MyFormParam

#------ Label
$MyParam_Label = @{
    Form = $Form
    Name = 'My Label'
	text = 'My Label'
	LocationX = 20 
	LocationY = 20
	Font = 'Arial'
	FontSize = 15
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,20,190,120))
}
add-FormObjectLabelLight @MyParam_Label

#------ LinkLabel
$LinklabelScanParam = @{
    Form = $Form
    Name = 'My LinkLabel'
    url = 'https://example.com/'
	text = "Url Example Link Label"
	LocationX = 20 
	LocationY = 110
	Font = 'Arial'
	FontSize = 15
	FontStyle = 'italic'
    ForeColor = 'yellow'
}
add-FormObjectLinkLabelLight @LinklabelScanParam

#------ TextBox
$MyParam_TextBox = @{
    Form = $Form
    Name = 'My TextBox'	
    text = 'MyTextBox'
	Height = 50
	Width = 250
	Multiline = $true
	LocationX = 20 
	LocationY = 55
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'italic'
	ForeColor = 'Black' #$([System.Drawing.Color]::FromArgb(255,255,255,255))
}
add-FormObjectTextBoxLight @MyParam_TextBox


#------ ComboBox
$MyParam_ComboBox = @{
    Form = $Form
    Name = 'My ComboBox'
	Height = 150
	Width = 200
	LocationX = 20 
	LocationY = 150
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,0,100,200))
	Items = @('MyCombobox Item 0','BlaBla',2,3)
	SelectedIndex = 0
}
add-FormObjectComboBoxLight @MyParam_ComboBox


#------ ProgressBar
$MyParam_ProgressBar = @{
    Form = $Form
    Name = 'MyProgressBar'
	Height = 45
	Width = 500
	LocationX = 20
	LocationY = 200
	Min =40
	InitialValue =43
	Max =50
	step = 1
	ForeColor = $([System.Drawing.Color]::FromArgb(100,30,40,190))
}
add-FormObjectProgressBarLight @MyParam_ProgressBar 
#Increment the progressbar
    #($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).PerformStep()
#Hide the progressBar
    #($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).hide()


#------ Button
$MyParam_Button = @{
    Form = $Form
    Name = 'MyButton'
	text = 'Increment ProgressBar'
	Height = 50
	Width = 150
	LocationX = 20 
	LocationY = 250
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = 'Black'
	BackColor = $([System.Drawing.Color]::FromArgb(30,100,20,60))
}
add-FormObjectButtonLight @MyParam_Button
#add an action after clic
($Form.Controls |Where-Object {$_.Name -eq 'MyButton' }).Add_Click({
    if (($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).value -eq ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).Maximum) {($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).hide()}
    ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).PerformStep()
})


#------ PictureBox
$MyParam_PictureBox = @{
    Form = $Form
    Name = 'My PictureBox'
	ImgFullPath = "$PSScriptRoot\Sample.png"
	Height =150
	Width = 100
    Ratio = 1
	SizeMode = 1
	LocationX = 20 
	LocationY = 350
}
add-FormObjectPictureBoxLight @MyParam_PictureBox


#------ CheckBox
$MyParam_CheckBox = @{
    Form = $Form
    Name = 'My CheckBox'
    Text = 'My CheckBox text'
	Height = 20
	Width = 200
	LocationX = 20 
	LocationY = 500
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,50,20,180))
	Checked = $false
}
add-FormObjectCheckBoxLight @MyParam_CheckBox


#------ RadioButtons
$MyParam_RadioButton1 = @{
    Form = $Form
    Name = 'My MyRadioButton1'
    Text = 'MyRadioButton1'
	Height = 20
	Width = 200
	LocationX = 20 
	LocationY = 600
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,40,15,170))
	Checked = $true
}
add-FormObjectRadioButtonLight @MyParam_RadioButton1


$MyParam_RadioButton2 = @{
    Form = $Form
    Name = 'My MyRadioButton2'
    Text = 'MyRadioButton2'
	Height = 20
	Width = 200
	LocationX = 300 
	LocationY = 600
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,40,15,170))
	Checked = $false
}
add-FormObjectRadioButtonLight @MyParam_RadioButton2


$MyParam_RadioButton3 = @{
    Form = $Form
    Name = 'My MyRadioButton3'
    Text = 'MyRadioButton3'
	Height = 20
	Width = 200
	LocationX = 600 
	LocationY = 600
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,40,15,170))
	Checked = $false
}
add-FormObjectRadioButtonLight @MyParam_RadioButton3



#------ GroupBox with Radiobuttons
#GroupBox
$MyParam_GroupBox = @{
    text ='My GroupBox'
    Height = 150
    Width = 400
    LocationX=20
    LocationY=750
    BackColor = 'LightBlue'
	ForeColor = $([System.Drawing.Color]::FromArgb(200,255,255,255))
}
$MyGroupBox = New-FormObjectGroupBoxLight @MyParam_GroupBox

#RadioButtons
$MyParam_RadioButton4 = @{
    Form = $MyGroupBox
    Name = 'My RadioButton4'
    Text = 'MyRadioButton4'
	Height = 20
	Width = 150
	LocationX = 20 
	LocationY = 20
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,60,30,190))
	Checked = $false
}
add-FormObjectRadioButtonLight @MyParam_RadioButton4

$MyParam_RadioButton5 = @{
    Form = $MyGroupBox
    Name = 'My MyRadioButton5'
    Text = 'MyRadioButton5'
	Height = 20
	Width = 150
	LocationX = 200 
	LocationY = 20
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold'
	ForeColor = 'Red'
	Checked = $true
}
add-FormObjectRadioButtonLight @MyParam_RadioButton5

$Form.Controls.Add($MyGroupBox)  


#------ Panel with Radiobuttons and CheckBox
#Panel
$MyParam_Panel = @{
    text ='My Panel'
    Height = 150
    Width = 400
    LocationX=600
    LocationY=750
    BackColor = 'LightBlue'
	ForeColor = $([System.Drawing.Color]::FromArgb(200,255,255,255))
    AutoScroll = $true
}
$MyPanel = New-FormObjectPanelLight @MyParam_Panel

#RadioButtons
$MyParam_RadioButton6 = @{
    Form = $MyPanel
    Name = 'My MyRadioButton6'
    Text = 'MyRadioButton6'
	Height = 20
	Width = 150
	LocationX = 20 
	LocationY = 20
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,60,10,185))
	Checked = $false
}
add-FormObjectRadioButtonLight @MyParam_RadioButton6

$MyParam_RadioButton7 = @{
    Form = $MyPanel
    Name = 'My MyRadioButton7'
    Text = 'MyRadioButton7'
	Height = 20
	Width = 150
	LocationX = 200 
	LocationY = 20
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = 'Green'
	Checked = $true
}
add-FormObjectRadioButtonLight @MyParam_RadioButton7

#CheckBox
$MyParam_CheckBox2 = @{
    Form = $MyPanel
    Name = 'My CheckBox2'
    Text = 'My CheckBox 2'
	Height = 20
	Width = 200
	LocationX = 20 
	LocationY = 200
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,50,14,174))
	Checked = $false
}
add-FormObjectCheckBoxLight @MyParam_CheckBox2

$Form.Controls.Add($MyPanel)


#------ TabControl with 2 TabPages, each hosting 1 object
#TabControl
$MyParam_TabControl = @{
	Height = 500
	Width = 500
	LocationX = 800
	LocationY = 20
    Multiline = $true
    SelectedIndex = 0
}
$MyTabControl = New-FormObjectTabControlLight @MyParam_TabControl
$Form.Controls.add($MyTabControl)

#TabPage1
$MyParam_Tabpage1 = @{
	Text = 'My tab 1'
	TabIndex = 0
	BackColor = 'Green'
}
$Tabpage1 = New-FormObjectTabPageLight @MyParam_Tabpage1
$MyTabControl.Controls.add($Tabpage1)

#Object in tab Page 1
$MyParam_TextBox_Tab1 = @{
    Form = $Tabpage1
    Name = 'MyTxtBoxTab1'
	text = 'MyTextBox in Tab 1'
	Height = 50
	Width = 250
	LocationX = 20 
	LocationY = 55
}
add-FormObjectTextBoxLight @MyParam_TextBox_Tab1


#TabPage 2
$MyParam_Tabpage2 = @{
	Text = 'My tab 2'
	TabIndex = 1
}
$Tabpage2 = New-FormObjectTabPageLight @MyParam_Tabpage2
$MyTabControl.Controls.add($Tabpage2)

#Object in tab Page 2
$MyParam_Label_Tab2 = @{
    Form = $Tabpage2
    Name = 'Mylbltab2'
	text = 'MyLabel in tab 2'
	LocationX = 20 
	LocationY = 20
}
add-FormObjectLabelLight @MyParam_Label_Tab2


#------ Calendar
$MyParam_Calendar = @{
    Form = $Form
    Name = 'My Calendar'
	Type = 'MonthDisplayed'
	LocationX = 1350 
	LocationY = 400
    Width = 400
    Height = 400
}
add-FormObjectCalendarLight @MyParam_Calendar

#------ ListView
$MyParam_ListView = @{
    Form = $Form
    Name = 'My ListView'
    MyColumns = @(
        ,('Name',35)
        ,('Age',90)
        ,('Sex',50)
        ,('Other',100)
    )
  	MyItems = @(
        ,('Jean',35,'M')
        ,('Sophie',25,'F','MyAbout')
        ,('Luc',47,'M','IsLuc')
        ,('Angela',22,'F','Accountant')
    )  
    CheckBoxes=$true
    GridLines=$true
    AutoResizeColumns = 2
	Height = 250
	Width = 400
	LocationX = 1400 
	LocationY = 25
	Font = 'Tahoma'
	FontSize = 12
	FontStyle = 'Regular'
	ForeColor = 'Black'
	BackColor = $([System.Drawing.Color]::FromArgb(100,110,180))
}
add-FormObjectListViewLight @MyParam_ListView


#------ DomainUpDown
$MyParam_DomainUpDown = @{
    Form = $Form
    Name = 'My DomainUpDown'
    text = 'DomainUpDown base text' 	
    Width = 500
	LocationX = 20 
	LocationY = 1050
	Font = 'Comic sans MS'
	FontSize = 18
	FontStyle = 'Regular'
	ForeColor = 'Red'
	BackColor = $([System.Drawing.Color]::FromArgb(14,15,200))
    MyItems = ('My Item 1','My Item 2')
}
add-FormObjectDomainUpDownLight @MyParam_DomainUpDown


#------ NumericUpDown
$MyParam_NumericUpDown = @{
    Form = $Form
    Name = 'My NumericUpDown'
    Width = 500
    LocationX = 20 
    LocationY = 1150
    Font = 'Comic sans MS'
    FontSize = 18
    FontStyle = 'bold'
    ForeColor = 'Green'
    BackColor = $([System.Drawing.Color]::FromArgb(140,150,160))  
    Max = 10000
    Min = - 5
    InitialValue = 5000
    Step = 0.5
    Decimal = 2
}
add-FormObjectNumericUpDownLight @MyParam_NumericUpDown


#------ ListBox
$MyParam_ListBox = @{
    Form = $Form
    Name = 'My ListBox'
    Height = 1000
    Width = 600
    LocationX = 20 
    LocationY = 1200
    Font = 'Times New Roman'
    FontSize = 24
    FontStyle = 'italic'
    ForeColor = 'Blue'
    BackColor = $([System.Drawing.Color]::FromArgb(200,210,220))  
    ScrollAlwaysVisible = $true
    MultiColumn = $false
    SelectionMode = 3
    Items=('ListBox Item 0','ListBox Item 1','My BlaBla')
}
add-FormObjectListBoxLight @MyParam_ListBox


#------ Form - Activate/Show
$Form.Add_Shown({$Form.Activate()})
$Form.AutoScroll = $true
#To Stop script until the form is closed
$Form.ShowDialog() | Out-Null
