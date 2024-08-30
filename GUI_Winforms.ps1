# ----------------------------------------------------
# -- Projet : GUI Winforms for Powershell
# -- Author : Ronaf
# -- Created : 30/08/2024
# -- Update : 
# --  
# ----------------------------------------------------


#=====================================================================================================
#======================================== Prerequisites  =============================================
#=====================================================================================================
#These lines should be in your script to pass certain parameters to the functions (like colors)
#Add-Type -AssemblyName System.Windows.Forms
#Add-Type -AssemblyName System.Drawing

#=====================================================================================================
#========================================== Create Form ==============================================
#=====================================================================================================
function New-FormLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [int]$Height,

        [Parameter(Mandatory=$false)]
        [int]$Width,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor = 'LightBlue'

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
        
    $Form = New-Object Windows.Forms.Form
    $Form.Text = $Text
    $Form.BackColor=$BackColor
    $Form.AutoScroll = $true #display windows scrollbar

    if ($Width+$Height -gt 0) {
        $Form.Width = $Width
        $Form.Height = $Height
        } else {
        $Form.WindowState = 'Maximized' #https://learn.microsoft.com/en-us/dotnet/api/system.windows.windowstate
        }

    #If willing to fullscreen without borders $Form.FormBorderStyle = 'None';



    return $Form


    <#
    .SYNOPSIS

    Create a Form used for GUI.

    .DESCRIPTION

    Create a Form for Windows Display. Light version with basics parameters
    Objects (Lable, Button, Combobox) should be added to this form.

    .PARAMETER Text
    Form's Text (Header)

    .PARAMETER Height
    Form's Height. If Height and Width are omissed, the form will be displayed in Maximized window.

    .PARAMETER Width
    Form's Width. If Height and Width are omissed, the form will be displayed in Maximized window.

    .PARAMETER BackColor 
    Color of the Background's Form. 
    See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color

    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.Form

    .EXAMPLE

    $Form = New-FormLight -text "My Form" -BackColor 'Black'

    #add controls to my form
    $Form.Controls.add($MyFormObject)

    #activate/show form
    $Form.Add_Shown({$Form.Activate()})

    #To Stop script until the form is closed
    $Form.ShowDialog() 

    #To continue script even if the form is still displayed. Example : usefull for progress bar
    [void]$Form.Show()
    #<MyScriptHere>
    $Form.Close()

    .EXAMPLE

    $MyFormParam = @{
        text = "My Form"
        Width = 0
        Height = 0
        BackColor = 'Black'
    }
    $Form = New-FormLight @MyFormParam

    #add controls to my form
    $Form.Controls.add($MyFormObject)

    #activate/show form
    $Form.Add_Shown({$Form.Activate()})

    #To Stop script until the form is closed
    $Form.ShowDialog() 

    #To continue script even if the form is still displayed. Example : usefull for progress bar
    [void]$Form.Show()
    #<MyScriptHere>
    $Form.Close()

    .LINK

    https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.form

    #>    
        
}

#=====================================================================================================
#======================================= Sub-Form Objects ============================================
#=====================================================================================================
<#
    Objects designed to host other objects. They still need to be added to a form
    $MyFormPreviouslyCreated.Controls.add($MySubForm)
#>	

function New-FormObjectGroupBoxLight {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My GroupBox Title',

        [Parameter(Mandatory=$false)]
        [int]$Height = 500,

        [Parameter(Mandatory=$false)]
        [int]$Width = 500, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor = 'LightBlue'


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Point($LocationX,$LocationY)
$groupBox.text = $Text
$groupBox.Size = New-Object System.Drawing.Size($Width,$Height)
$groupBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$groupBox.BackColor = $BackColor
$groupBox.forecolor = $Forecolor
    
    return $groupBox


<#
.SYNOPSIS

Create a GroupBox Object used for GUI.

.DESCRIPTION

Create a GroupBox Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)
Usefull for
 - Grouping together radiobuttons
 - Creating a group of objects and move/duplicate them easily - also see Panel
Note that object add to the GroupBox have a new X/Y Axis, where top left of the groupbox is 0,0

.PARAMETER Text
GroupBox's Text

.PARAMETER Height
GroupBox's Height

.PARAMETER Width
GroupBox's Width

.PARAMETER LocationX 
Location of the GroupBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the GroupBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER Font 
GroupBox's Font

.PARAMETER FontSize 
GroupBox's FontSize

.PARAMETER FontStyle 
GroupBox's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER ForeColor 
Color of the GroupBox's title characters. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the GroupBox's backgroud. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.groupbox

.EXAMPLE

$MyFormObject = New-FormObjectGroupBoxLight -text 'My GroupBox' -LocationX 15 -LocationY 150 
to add an object to the groupbox
    $MyGroupBox.Controls.add($MyFormObject)
to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyGroupBox)

.EXAMPLE

$MyParam = @{
    text ='My GroupBox'
    Height = 150
    Width = 400
    LocationX=20
    LocationY=750
    BackColor = 'LightBlue'
	ForeColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
    Font = 'Arial'
	FontSize = 26
	FontStyle = 'underline'
}
$MyFormObject = New-FormObjectGroupBoxLight @MyParam

to add an object to the groupbox
    $MyGroupBox.Controls.add($MyFormObject)
to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyGroupBox)

.LINK

https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.groupbox

#>    
            
}

function New-FormObjectPanelLight {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My Panel Title',

        [Parameter(Mandatory=$false)]
        [int]$Height = 500,

        [Parameter(Mandatory=$false)]
        [int]$Width = 500, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor = 'LightBlue',

        [Parameter(Mandatory=$false)]
        [bool]$AutoScroll = $false


    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
        
    $Panel = New-Object System.Windows.Forms.Panel
    $Panel.Location = New-Object System.Drawing.Point($LocationX,$LocationY)
    $Panel.text = $Text
    $Panel.Size = New-Object System.Drawing.Size($Width,$Height)
    $Panel.BackColor = $BackColor
    $Panel.forecolor = $Forecolor
    $Panel.AutoScroll = $AutoScroll
        
        return $Panel


    <#
    .SYNOPSIS

    Create a Panel Object used for GUI.

    .DESCRIPTION

    Create a Panel Object for Windows Display. Light version with basics parameters
    Must be added to a Form (Windows.Forms.Form)
    Usefull for
    - Group together radiobutton
    - Create a group of objects and move/duplicate them easily - also see GroupBox
    Note that objects added to the Panel have a new X/Y Axis, where top left of the Panel is 0,0

    .PARAMETER Text
    Panel's Text

    .PARAMETER Height
    Panel's Height

    .PARAMETER Width
    Panel's Width

    .PARAMETER LocationX 
    Location of the Panel in the form, on the X-Axis. Top Left is 0. Positive value expected

    .PARAMETER LocationY 
    Location of the Panel in the form, on the Y-Axis. Top Left is 0. Positive value expected

    .PARAMETER ForeColor 
    Color of the Panel's title characters. 
    See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
    $([System.Drawing.Color]::FromArgb(200,200,200,200))
    'Red'

    .PARAMETER BackColor 
    Color of the Panel's backgroud. 
    See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
    $([System.Drawing.Color]::FromArgb(200,200,200,200))
    'Red'

    .PARAMETER AutoScroll 
    Enable/disable scrollBar

    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.Panel

    .EXAMPLE

    $MyFormObject = New-FormObjectPanelLight -text 'My Panel' -LocationX 15 -LocationY 150 
    to add an object to the Panel
        $MyPanel.Controls.add($MyFormObject)
    to add to a form (Windows.Forms.Form) : 
        $Form.Controls.add($MyPanel)

    .EXAMPLE

    $MyParam = @{
        text ='My Panel'
        Height = 150
        Width = 400
        LocationX=20
        LocationY=750
        BackColor = 'LightBlue'
        ForeColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
    }
    $MyFormObject = New-FormObjectPanelLight @MyParam

    to add an object to the Panel
        $MyPanel.Controls.add($MyFormObject)
    to add to a form (Windows.Forms.Form) : 
        $Form.Controls.add($MyPanel)

    .LINK

    https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.Panel

    #>    
        
}

function New-FormObjectTabControlLight {
    param (
        [Parameter(Mandatory=$false)]
        [int]$Height = 500,

        [Parameter(Mandatory=$false)]
        [int]$Width = 500, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,
        
        [Parameter(Mandatory=$false)]
        [bool]$Multiline = $true,

        [Parameter(Mandatory=$false)]
        [int]$SelectedIndex =0


    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
        
    $TabControl = New-Object System.Windows.Forms.TabControl
    $TabControl.Size = New-Object System.Drawing.Size($Width,$Height)
    $TabControl.Location = New-Object System.Drawing.Point($LocationX,$LocationY)
    $TabControl.Multiline = $Multiline
    $TabControl.SelectedIndex = $SelectedIndex
        
        return $TabControl


    <#
    .SYNOPSIS

    Create a TabControl Object used for GUI.

    .DESCRIPTION

    Create a TabControl Object for Windows Display. Light version with basics parameters
    Must be added to a Form (Windows.Forms.Form)
    Must add tabPage to this object (System.Windows.Forms.TabPage)

    .PARAMETER Height
    TabControl's Height

    .PARAMETER Width
    TabControl's Width

    .PARAMETER LocationX 
    Location of the TabControl in the form, on the X-Axis. Top Left is 0. Positive value expected

    .PARAMETER LocationY 
    Location of the TabControl in the form, on the Y-Axis. Top Left is 0. Positive value expected

    .PARAMETER Multiline 
    Enable/Disable display of Tabs on mutliple lines

    .PARAMETER SelectedIndex 
    Chose the selected Tab on Initialization


    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.TabControl

    .EXAMPLE

    $MyTabControl = New-FormObjectTabControlLight -Height 500 -Width 500 -LocationX 800 -LocationY 20
    to add a tab to the TabControl
        $MyTabControl.Controls.add($MyTabPage)
    to add to a form (Windows.Forms.Form) : 
        $Form.Controls.add($MyTabControl)

    .EXAMPLE

    $MyParam_TabControl = @{
        Height = 500
        Width = 500
        LocationX = 800
        LocationY = 20
        Multiline = $true
        SelectedIndex = 0
    }
    $MyTabControl = New-FormObjectTabControlLight @MyParam_TabControl

    to add a tab to the TabControl
        $MyTabControl.Controls.add($MyTabPage)
    to add to a form (Windows.Forms.Form) : 
        $Form.Controls.add($MyTabControl)

    .LINK

    https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.TabControl

    #>    
    
}

function New-FormObjectTabPageLight {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My Tab',

        [Parameter(Mandatory=$false)]
        [int]$TabIndex =0,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor


    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
        
    $TabPage = New-Object System.Windows.Forms.TabPage
    $TabPage.Padding = '5,5,5,5'
    $TabPage.TabIndex = $TabIndex
    $TabPage.Text = $Text
    if ($BackColor -eq $null) {
        $TabPage.UseVisualStyleBackColor = $True 
        } else {
        $TabPage.backcolor = $BackColor
        }
        

    return $TabPage


    <#
    .SYNOPSIS

    Create a TabPage Object used for GUI.

    .DESCRIPTION

    Create a TabPage Object for Windows Display. Light version with basics parameters
    Must be added to a TabControl (System.Windows.Forms.TabControl)

    .PARAMETER Text
    TabPage's Text (Tab Label)

    .PARAMETER TabIndex
    TabPage's Index. Usefull to give a dedicated index

    .PARAMETER BackColor 
    Color of the TabPage's backgroud, if specified. If not specified, use UseVisualStyleBackColor = $True
    See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
    $([System.Drawing.Color]::FromArgb(200,200,200,200))
    'Red'


    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.TabPage

    .EXAMPLE

    $Tabpage1 = New-FormObjectTabPageLight -text 'My tab 1' -TabIndex 0 -BackColor 'Green'

    to add a tab to the TabControl
        $MyTabControl.Controls.add($Tabpage1)

    .EXAMPLE

    $MyParam_Tabpage1 = @{
        Text = 'My tab 1'
        TabIndex = 0
        BackColor = 'Green'
    }
    $Tabpage1 = New-FormObjectTabPageLight @MyParam_Tabpage1

    to add a tab to the TabControl
        $MyTabControl.Controls.add($Tabpage1)


    .LINK

    https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.TabPage

    #>    
        
}

#=====================================================================================================
#==================================== Create Stand Alone Object ======================================
#=====================================================================================================
<#
    Stand Alone Objects, meaning they should be added to a form to be displayed
    Pro :
        can be assigned to a variable thus being easily accessible to perform methods
            Ex : $MyStandAloneObject.hide()
    Con :
        Must be added to a form throught a new line of code after the creating of the object
            Ex : $MyFormPreviouslyCreated.Controls.add($MyStandAloneObject)
#>		

function New-FormObjectLabelLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'regular',

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
        
    $Label = New-Object Windows.Forms.Label
    $Label.Text = $Text
    $Label.Font = New-Object Drawing.Font($Font, $FontSize, [System.Drawing.FontStyle]($FontStyle))
    $Label.AutoSize = $true
    $Label.Location = New-Object Drawing.Point($LocationX,$LocationY)
    $Label.ForeColor = $ForeColor

        return $Label


    <#
    .SYNOPSIS

    Create a Label Object used for GUI.

    .DESCRIPTION

    Create a Label Object for Windows Display. Light version with basics parameters.
    Must be added to a Form (Windows.Forms.Form)

    .PARAMETER Text
    Label's Text

    .PARAMETER Font 
    Label's Font

    .PARAMETER FontSize 
    Label's FontSize

    .PARAMETER FontStyle 
    Label's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle
    Example : 'italic,bold'

    .PARAMETER LocationX 
    Location of the label in the form, on the X-Axis. Top Left is 0. Positive value expected

    .PARAMETER LocationY 
    Location of the label in the form, on the Y-Axis. Top Left is 0. Positive value expected

    .PARAMETER ForeColor 
    Color of the label's characters . See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
    Example :
    $([System.Drawing.Color]::FromArgb(200,200,200,200))
    'Red'

    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.label

    .EXAMPLE

    $MyFormObject = New-FormObjectLabelLight -text 'My Label' -LocationX 15 -LocationY 150

    to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyFormObject)

    .EXAMPLE

    $MyParam = @{
        text = 'My Label'
        LocationX = 15 
        LocationY = 150
        Font = 'Arial'
        FontSize = 10
        FontStyle = 'Bold,underline'
        ForeColor = $([System.Drawing.Color]::FromArgb(255,0,130,120))
    }
    $MyFormObject = New-FormObjectLabelLight @MyParam

    to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyFormObject)

    .LINK

    https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.label

    #>    
    
}
function New-FormObjectLinkLabelLight {
    param (
        [Parameter(Mandatory=$true)]
        $url,

        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'regular',

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing


    $LinkLabel = New-Object Windows.Forms.LinkLabel

    #to pass the Variable on the add_click scope
    $LinkLabel | Add-Member -NotePropertyMembers @{CustomUrl = $url}
    $LinkLabel.add_Click({Start-Process $this.CustomUrl})


    $LinkLabel.Text = $text
    $LinkLabel.LinkColor = $ForeColor
    $LinkLabel.ActiveLinkColor = "RED"

    $LinkLabel.Font = New-Object Drawing.Font($Font, $FontSize, [System.Drawing.FontStyle]($FontStyle))
    $LinkLabel.AutoSize = $true
    $LinkLabel.Location = New-Object Drawing.Point($LocationX,$LocationY)

        return $LinkLabel


    <#
    .SYNOPSIS

    Create a LinkLabel Object used for GUI.

    .DESCRIPTION

    Create a LinkLabel Object for Windows Display. Light version with basics parameters.
    Must be added to a Form (Windows.Forms.Form)

    .PARAMETER Url
    Url used when the LinkLabel is clicked on

    .PARAMETER Text
    LinkLabel's Text

    .PARAMETER Font 
    LinkLabel's Font

    .PARAMETER FontSize 
    LinkLabel's FontSize

    .PARAMETER FontStyle 
    LinkLabel's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle
    Example : 'italic,bold'

    .PARAMETER LocationX 
    Location of the LinkLabel in the form, on the X-Axis. Top Left is 0. Positive value expected

    .PARAMETER LocationY 
    Location of the LinkLabel in the form, on the Y-Axis. Top Left is 0. Positive value expected

    .PARAMETER ForeColor 
    Color of the LinkLabel's characters (link color).

    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.LinkLabel

    .EXAMPLE

    $MyFormObject = New-FormObjectLinkLabelLight -url 'https://example.com/' -text 'MyText' -LocationX 15 -LocationY 150

    to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyFormObject)

    .EXAMPLE

        $LinklabelScanParam = @{
            url = 'https://example.com/'
            text = "Url Example Link Label"
            LocationX = 20 
            LocationY = 110
            Font = 'Arial'
            FontSize = 15
            FontStyle = 'italic'
            ForeColor = 'yellow'
        }
        $LinklabelScan = New-FormObjectLinkLabelLight @LinklabelScanParam
        $Form.Controls.add($LinklabelScan)

    .LINK

    https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.linklabel

    #>    
        
}

function New-FormObjectTextBoxLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [bool]$Multiline = $false,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
        
    $TextBox = New-Object System.Windows.Forms.textbox
    $TextBox.Text = $Text
    $TextBox.Multiline = $Multiline
    $TextBox.Size = New-Object System.Drawing.Size($Width,$Height)
    $TextBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
    $TextBox.Location = New-Object Drawing.Point($LocationX,$LocationY)
    $TextBox.ForeColor = $ForeColor
        
        return $TextBox


    <#
    .SYNOPSIS

    Create a TextBox used for GUI.

    .DESCRIPTION

    Create a TextBox for Windows Display. Light version with basics parameters
    Must be added to a Form (Windows.Forms.Form)

    .PARAMETER Text
    TextBox's Text

    .PARAMETER Height
    TextBox's Height

    .PARAMETER Width
    TextBox's Width

    .PARAMETER Multiline
    Allow/Disallow display on multiple lines

    .PARAMETER Font 
    TextBox's Font

    .PARAMETER FontSize 
    TextBox's FontSize

    .PARAMETER FontStyle 
    TextBox's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

    .PARAMETER LocationX 
    Location of the TextBox in the form, on the X-Axis. Top Left is 0. Positive value expected

    .PARAMETER LocationY 
    Location of the TextBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

    .PARAMETER ForeColor 
    Color of the TextBox's characters . See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
    Example :
    $([System.Drawing.Color]::FromArgb(200,200,200,200))
    'Red'

    None.

    .OUTPUTS

    System.Windows.Forms.textbox

    .EXAMPLE


    $MyFormObject = New-FormObjectTextBoxLight -text 'My TextBox' -LocationX 15 -LocationY 150

    to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyFormObject)

    .EXAMPLE

    $MyParam = @{
        text = 'My TextBox'
        Height = 50
        Width = 70
        Multiline = $true
        LocationX = 15 
        LocationY = 150
        Font = 'Arial'
        FontSize = 10
        FontStyle = 'Bold,underline'
        ForeColor = 'Black' #$([System.Drawing.Color]::FromArgb(200,200,200,200))
    }
    $MyFormObject = New-FormObjectTextBoxLight @MyParam

    to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyFormObject)

    .LINK

    https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.textbox

    #>    
        
}
function New-FormObjectComboBoxLight {
    param (
        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$true)]
        $Items, 

        [Parameter(Mandatory=$false)]
        [int]$SelectedIndex = 0

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
        
    $ComboBox = New-Object system.Windows.Forms.ComboBox
    $ComboBox.width = $Width
    $ComboBox.autosize = $true
    $ComboBox.location = New-Object System.Drawing.Point($LocationX,$LocationY)
    $ComboBox.Size = New-Object System.Drawing.Size($Width,$Height)
    $ComboBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
    $ComboBox.ForeColor = $ForeColor
    # Add the items in the dropdown list
    $Items  | ForEach-Object {[void] $ComboBox.Items.Add($_)}
    # Select the default value
    $ComboBox.SelectedIndex = $SelectedIndex
        
        return $ComboBox


    <#
        .SYNOPSIS

        Create a ComboBox used for GUI.

        .DESCRIPTION

        Create a ComboBox for Windows Display. Light version with basics parameters
        Must be added to a Form (Windows.Forms.Form)

        .PARAMETER Height
        ComboBox's Height

        .PARAMETER Width
        ComboBox's Width

        .PARAMETER Font 
        ComboBox's Font

        .PARAMETER FontSize 
        ComboBox's FontSize

        .PARAMETER FontStyle 
        ComboBox's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

        .PARAMETER LocationX 
        Location of the ComboBox in the form, on the X-Axis. Top Left is 0. Positive value expected

        .PARAMETER LocationY 
        Location of the ComboBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

        .PARAMETER ForeColor 
        Color of the ComboBox's characters.
        See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
        $([System.Drawing.Color]::FromArgb(200,200,200,200))
        'Red'

        .PARAMETER Items 
        Array used to populate the ComboBox.

        .PARAMETER SelectedIndex 
        Index of the default item

        .INPUTS

        None.

        .OUTPUTS

        System.Windows.Forms.ComboBox

        .EXAMPLE

        $MyFormObject = New-FormObjectComboBoxLight  -LocationX 15 -LocationY 150 -Items 1,'BlaBla',3,5

        to add to a form (Windows.Forms.Form) : 
        $Form.Controls.add($MyFormObject)

        to get selected value :
        $MyFormObject.text

        .EXAMPLE

        $MyParam = @{
            Height = 150
            Width = 200
            LocationX = 15 
            LocationY = 150
            Font = 'Arial'
            FontSize = 10
            FontStyle = 'Bold,underline'
            ForeColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
            Items = @(1,'BlaBla',3,5)
            SelectedIndex = 1
        }
        $MyFormObject = New-FormObjectComboBoxLight @MyParam

        to add to a form (Windows.Forms.Form) : 
        $Form.Controls.add($MyFormObject)

        to get selected value :
        $MyFormObject.text

        .LINK

        https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.combobox

    #>    
    
}

function New-FormObjectButtonLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',
		
		[Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor = 'LightGray'

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $Button = New-Object System.Windows.Forms.Button
    $Button.Location = New-Object System.Drawing.Point($LocationX,$LocationY)
    $Button.Size = New-Object System.Drawing.Size($Width,$Height)
    $Button.Font=New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
    $Button.ForeColor = $ForeColor
    $Button.BackColor = $BackColor
    $Button.Text = $Text

        return $Button

    <#
        .SYNOPSIS

        Create a Button used for GUI.

        .DESCRIPTION

        Create a Button for Windows Display. Light version with basics parameters
        Must be added to a Form (Windows.Forms.Form)

        .PARAMETER Text
        Button's Text

        .PARAMETER Height
        Button's Height

        .PARAMETER Width
        Button's Width

        .PARAMETER Font 
        Button's Font

        .PARAMETER FontSize 
        Button's FontSize

        .PARAMETER FontStyle 
        Button's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

        .PARAMETER LocationX 
        Location of the Button in the form, on the X-Axis. Top Left is 0. Positive value expected

        .PARAMETER LocationY 
        Location of the Button in the form, on the Y-Axis. Top Left is 0. Positive value expected

        .PARAMETER BackColor 
        Color of the Button's Background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
        $([System.Drawing.Color]::FromArgb(200,200,200,200))
        'Red'

        .PARAMETER ForeColor 
        Color of the characters's Button. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
        $([System.Drawing.Color]::FromArgb(200,200,200,200))
        'Red'


        .INPUTS

        None.

        .OUTPUTS

        System.Windows.Forms.Button

        .EXAMPLE

        $MyParam = @{
            text = 'My Button'
            Height = 150
            Width = 10
            LocationX = 15 
            LocationY = 150
            Font = 'Arial'
            FontSize = 10
            FontStyle = 'Bold,underline'
            ForeColor = 'Black'
            BackColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
        }
        $MyFormObject = New-FormObjectButtonLight @MyParam

        to add an action after clic
        $MyFormObject.Add_Click({
        write-host "hello world"
            })


        .EXAMPLE

        $MyFormObject = New-FormObjectButtonLight -text 'My Button' -LocationX 15 -LocationY 150

        to add an action after clic
        $MyFormObject.Add_Click({
            write-host "hello world"
            })

        .LINK

        https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.button

    #>    
        
}

function New-FormObjectProgressBarLight {
    param (
        [Parameter(Mandatory=$false)]
        [int]$Height = 40,

        [Parameter(Mandatory=$false)]
        [int]$Width = 500,

        [Parameter(Mandatory=$false)]
        [int]$LocationX=20,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=20,

        [Parameter(Mandatory=$false)]
        [int]$Min=0,

        [Parameter(Mandatory=$false)]
        [int]$Max=100,

        [Parameter(Mandatory=$false)]
        [int]$InitialValue = $Min,

        [Parameter(Mandatory=$false)]
        [int]$Step=1,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Blue'
    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    
    $ProgressBar = New-Object System.Windows.Forms.ProgressBar
    $ProgressBar.Location = New-Object System.Drawing.Point($LocationX, $LocationY)
    $ProgressBar.Size = New-Object System.Drawing.Size($Width,$Height)
    $ProgressBar.Style = 1
    $ProgressBar.Minimum = $Min
    $ProgressBar.Maximum = $Max
    $ProgressBar.value = $InitialValue
    $ProgressBar.Step = $Step
    $ProgressBar.ForeColor = $ForeColor
            
        return $ProgressBar
        
    <#
    .SYNOPSIS

    Create a ProgressBar used for GUI.

    .DESCRIPTION

    Create a ProgressBar for Windows Display. Light version with basics parameters
    Must be added to a Form (Windows.Forms.Form)
    Doesn't update itself alone : should use the method "PerformStep()" to increment the steps
    No Label : use a label object 

    .PARAMETER Height
    ProgressBar's Height

    .PARAMETER Width
    ProgressBar's Width

    .PARAMETER Min 
    ProgressBar's minimal value

    .PARAMETER InitialValue 
    ProgressBar's Initial Value if not the minimal 

    .PARAMETER Max 
    ProgressBar's maximal value

    .PARAMETER Step 
    ProgressBar's step done when method "PerformStep()" is used

    .PARAMETER LocationX 
    Location of the ProgressBar in the form, on the X-Axis. Top Left is 0. Positive value expected

    .PARAMETER LocationY 
    Location of the ProgressBar in the form, on the Y-Axis. Top Left is 0. Positive value expected

    .PARAMETER ForeColor 
    Color of the ProgressBar's bar . See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
    $([System.Drawing.Color]::FromArgb(200,200,200,200))
    'Red'

    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.ProgressBar

    .EXAMPLE

    $MyParam = @{
        Height = 45
        Width = 500
        LocationX = 20
        LocationY = 25
        Min =40
        InitialValue =43
        Max =50
        step = 2
        ForeColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
    }
    $MyFormObject = New-FormObjectProgressBarLight @MyParam 

    #Increment the progressbar
    for (($i = $MyFormObject.Minimum); $i -lt $MyFormObject.Maximum; ($i = $MyFormObject.value))
    {
            $MyFormObject.PerformStep()
            Sleep -Seconds 1
    }

    #Hide the progressBar
    $ProgressBar.hide()

    .EXAMPLE

    $MyFormObject = New-FormObjectProgressBarLight -Min 40 -InitialValue 43 -Max 50 -step 2

    #Increment the progressbar
    for (($i = $MyFormObject.Minimum); $i -lt $MyFormObject.Maximum; ($i = $MyFormObject.value))
    {
            $MyFormObject.PerformStep()
            Sleep -Seconds 1
    }

    .LINK

    https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.progressbar

    #>    
    
}

function New-FormObjectPictureBoxLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ImgFullPath,

        [Parameter(Mandatory=$false)]
        [decimal]$Ratio = 1,

        [Parameter(Mandatory=$false)]
        [int]$Height,

        [Parameter(Mandatory=$false)]
        [int]$Width, 

        [ValidateSet(0,1,2,3,4)]
        [Parameter(Mandatory=$false)]
        [int]$SizeMode = 1, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$file = (get-item $ImgFullPath -force)
$img = [System.Drawing.Image]::Fromfile($file);

$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$pictureBox.Image = $img

#If Width/Height not passed to the function, resize the image
if($Width -eq 0) {$Width = ($img.Width)*$Ratio}
if($Height -eq 0) {$Height = ($img.Height)*$Ratio}
$pictureBox.Size = New-Object System.Drawing.Size($Width,$Height)
$pictureBox.SizeMode = $SizeMode 

    
    return $pictureBox


<#
.SYNOPSIS

Create a PictureBox Object used for GUI.

.DESCRIPTION

Create a PictureBox Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER ImgFullPath
FullPath of the image

.PARAMETER Ratio
AspectRatio of the Image (Height/Width).
Used when Height or Width is not passed to the function

.PARAMETER Height
Height used for the image. If not defined,image's Height  is used, with an AspectRatio

.PARAMETER Width
Width used for the image. If not defined, image's Width is used, with an AspectRatio

.PARAMETER SizeMode
SizeMode for the image. 
See https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.pictureboxsizemode

.PARAMETER LocationX 
Location of the PictureBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the PictureBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.PictureBox

.EXAMPLE


$MyFormObject = New-FormObjectPictureBoxLight -ImgFullPath 'C:\Users\MyUser\Pictures\Sample.PNG' -LocationX 15 -LocationY 150 -Ratio 0.1

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.EXAMPLE

$MyParam = @{
	ImgFullPath = 'C:\Users\MyUser\Pictures\Sample.PNG'
	Height =450
	Width = 150
    Ratio = 1
	SizeMode = 1
	LocationX = 15 
	LocationY = 150
}
$MyFormObject = New-FormObjectPictureBoxLight @MyParam

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.picturebox

#>    
    
    }

function New-FormObjectRadioButtonLight {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My Radiobutton',

        [Parameter(Mandatory=$false)]
        [int]$Height = 50,

        [Parameter(Mandatory=$false)]
        [int]$Width = 50, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$false)]
        [bool]$Checked= $false


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$RadioButton = New-Object System.Windows.Forms.RadioButton
$RadioButton.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$RadioButton.Size = New-Object System.Drawing.Size($Width,$Height)
$RadioButton.Checked = $Checked
$RadioButton.text = $Text
$RadioButton.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$RadioButton.ForeColor = $ForeColor
    
    return $RadioButton


<#
.SYNOPSIS

Create a RadioButton used for GUI.

.DESCRIPTION

Create a RadioButton for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Text
RadioButton's Text

.PARAMETER Height
RadioButton's Height

.PARAMETER Width
RadioButton's Width

.PARAMETER LocationX 
Location of the RadioButton in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the RadioButton in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER Font 
RadioButton's Font

.PARAMETER FontSize 
RadioButton's FontSize

.PARAMETER FontStyle 
RadioButton's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER ForeColor 
Color of the RadioButton's characters . See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER Checked 
Default Checked State

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.radiobutton

.EXAMPLE

$MyFormObject = New-FormObjectRadioButtonLight -text 'My Radiobutton' -LocationX 15 -LocationY 150 

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.EXAMPLE

$MyParam = @{
    Text = 'My Radiobutton'
	Height = 150
	Width = 200
	LocationX = 15 
	LocationY = 150
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
	Checked = $false
}
$MyFormObject = New-FormObjectRadioButtonLight @MyParam

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.radiobutton

#>    
    
    }

function New-FormObjectCheckBoxLight {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My CheckBox',

        [Parameter(Mandatory=$false)]
        [int]$Height = 50,

        [Parameter(Mandatory=$false)]
        [int]$Width = 50, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$false)]
        [bool]$Checked= $false


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$CheckBox = New-Object System.Windows.Forms.CheckBox
$CheckBox.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$CheckBox.Size = New-Object System.Drawing.Size($Width,$Height)
$CheckBox.Checked = $Checked
$CheckBox.text = $Text
$CheckBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$CheckBox.ForeColor = $ForeColor
    
    return $CheckBox


<#
.SYNOPSIS

Create a CheckBox Object used for GUI.

.DESCRIPTION

Create a CheckBox Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Text
CheckBox's Text

.PARAMETER Height
CheckBox's Height

.PARAMETER Width
CheckBox's Width

.PARAMETER LocationX 
Location of the CheckBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the CheckBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER Font 
CheckBox's Font

.PARAMETER FontSize 
CheckBox's FontSize

.PARAMETER FontStyle 
CheckBox's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER ForeColor 
Color of the CheckBox's characters. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER Checked 
Default Checked State (T/F)

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.checkbox

.EXAMPLE

$MyFormObject = New-FormObjectCheckBoxLight -text 'My CheckBox' -LocationX 15 -LocationY 150 

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.EXAMPLE

$MyParam = @{
    Text = 'My CheckBox'
	Height = 150
	Width = 200
	LocationX = 15 
	LocationY = 150
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
	Checked = $false
}
$MyFormObject = New-FormObjectCheckBoxLight @MyParam

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.checkbox

#>    
    
    }

function New-FormObjectCalendarLight {
    param (
        [ValidateSet("DatePicker", "MonthDisplayed")]
        [string]$Type = "DatePicker",

        [Parameter(Mandatory=$false)]
        [int]$Width = 150, 

        [Parameter(Mandatory=$false)]
        [int]$Height = 150, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

if ($Type -eq  "DatePicker") {   
    $Calendar = New-Object System.Windows.Forms.DateTimePicker}
    else {
    $Calendar = New-Object System.Windows.Forms.MonthCalendar
    }
$Calendar.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$Calendar.Width = $Width
$Calendar.Height = $Height
 
    
    return $Calendar


<#
.SYNOPSIS

Create a Calendar Object used for GUI.

.DESCRIPTION

Create a Calendar Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Type
Display a calendar with a date picker or a monthly calendar

.PARAMETER Width
Calendar's Width

.PARAMETER Height
Calendar's Height

.PARAMETER LocationX 
Location of the Calendar in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the Calendar in the form, on the Y-Axis. Top Left is 0. Positive value expected

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.DateTimePicker
or
System.Windows.Forms.MonthCalendar

.EXAMPLE

$MyCalendar = New-FormObjectCalendarLight -Type MonthDisplayed -LocationX 250 -LocationY 400

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyCalendar) 

.EXAMPLE

$MyParam_Calendar = @{
	Type = 'MonthDisplayed'
	LocationX = 250 
	LocationY = 400
    Width = 250
    Height = 250
}
$MyCalendar = New-FormObjectCalendarLight @MyParam_Calendar

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyCalendar) 

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.MonthCalendar

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.DateTimePicker

#>    
    
    }

function New-FormObjectListViewLight {
    param (
        [Parameter(Mandatory=$false)]
        [bool]$CheckBoxes =$false,

        [Parameter(Mandatory=$false)]
        [bool]$GridLines =$false,

        [Parameter(Mandatory=$true)]
        $MyColumns,

        [Parameter(Mandatory=$false)]
        [ValidateSet(0,1,2)]
        [int]$AutoResizeColumns = 0,

        [Parameter(Mandatory=$false)]
        $MyItems,

        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$Backcolor = 'White'


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$ListView = New-Object System.Windows.Forms.ListView
$ListView.View = [System.Windows.Forms.View]::Details
$ListView.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$Listview.Size = New-Object System.Drawing.Size($Width,$Height)
$Listview.Font= New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$Listview.CheckBoxes= $CheckBoxes
$Listview.GridLines= $GridLines
$Listview.backcolor = $Backcolor
$Listview.forecolor = $ForeColor

#Create My Columns
$MyColumns | ForEach-Object  {$ListView.Columns.Add($_[0],$_[1])} | Out-Null

# Add list items
Foreach ($MyItem in $MyItems) {
    $i =0
    foreach ($Item in $MyItem) {
        if ($i -eq 0) {
            $ListViewItem = New-Object System.Windows.Forms.ListViewItem($Item)
            $i++ } else {
            $ListViewItem.Subitems.Add($Item) | Out-Null
        }
    }
    $ListView.Items.Add($ListViewItem) | Out-Null
}
$ListViewItem = $null

$Listview.AutoResizeColumns($AutoResizeColumns) 
    
    return $Listview


<#
.SYNOPSIS

Create a Listview Object used for GUI.

.DESCRIPTION

Create a Listview Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER CheckBoxes
Enable/Disable Checkboxes

.PARAMETER GridLines
Enable/Disable GridLines

.PARAMETER AutoResizeColumns
Resize columns, based on Header content, Columns content or No resizing
See https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.columnheaderautoresizestyle

.PARAMETER MyColumns
Array with Arrays containing Columns Header and Columns Size
See https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.listview.columnheadercollection.add

.PARAMETER MyItems
Array with Arrays (Items) containing value for each columns

.PARAMETER Width
Listview's Width

.PARAMETER Height
Listview's Height

.PARAMETER Font 
Listview's Font

.PARAMETER FontSize 
Listview's FontSize

.PARAMETER FontStyle 
Listview's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the Listview in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the Listview in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the Items's characters in the Listview. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the Listview's background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.ListView

.EXAMPLE

$MyParam_ListView = @{
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
	BackColor = $([System.Drawing.Color]::FromArgb(100,100,180))
}
$MyListView = New-FormObjectListViewLight @MyParam_ListView
$Form.Controls.add($MyListView) 

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.ListView

#>    
    
    }

function New-FormObjectDomainUpDownLight {
    param (
        [Parameter(Mandatory=$false)]
        [string]$text,

        [Parameter(Mandatory=$false)]
        $MyItems,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$Backcolor = 'White'


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$DomainUpDown = New-Object System.Windows.Forms.DomainUpDown
$DomainUpDown.Width = $Width
$DomainUpDown.location = New-Object System.Drawing.Point($LocationX,$LocationY)
$DomainUpDown.Font= New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$DomainUpDown.backcolor = $Backcolor
$DomainUpDown.forecolor = $ForeColor
$DomainUpDown.text = $text

$MyItems | ForEach-Object  {$DomainUpDown.items.Add($_)} | Out-Null
    
    return $DomainUpDown


<#
.SYNOPSIS

Create a DomainUpDown Object used for GUI.

.DESCRIPTION

Create a DomainUpDown Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER text
DomainUpDown's text displayed before selection

.PARAMETER MyItems
Array with Items to feed the DomainUpDown

.PARAMETER Width
DomainUpDown's Width

.PARAMETER Font 
DomainUpDown's Font

.PARAMETER FontSize 
DomainUpDown's FontSize

.PARAMETER FontStyle 
DomainUpDown's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the DomainUpDown in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the DomainUpDown in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the Items's characters in the DomainUpDown. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the DomainUpDown's background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.DomainUpDown

.EXAMPLE

$MyParam_DomainUpDown = @{
    text = 'My text' 	
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
$MyDomainUpDown = New-FormObjectDomainUpDownLight @MyParam_DomainUpDown
$Form.Controls.add($MyDomainUpDown) 

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.DomainUpDown

#>    
    
    }

function New-FormObjectNumericUpDownLight {
    param (
        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$Backcolor = 'White',

        [Parameter(Mandatory=$false)]
        [int]$Min=-100,

        [Parameter(Mandatory=$false)]
        [int]$Max=100,

        [Parameter(Mandatory=$false)]
        [int]$InitialValue = $Min,

        [Parameter(Mandatory=$false)]
        [decimal]$Step=1,

        [Parameter(Mandatory=$false)]
        [decimal]$Decimal=0


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$NumericUpDown = New-Object System.Windows.Forms.NumericUpDown
$NumericUpDown.Width = $Width
$NumericUpDown.location = New-Object System.Drawing.Point($LocationX,$LocationY)
$NumericUpDown.Font= New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$NumericUpDown.backcolor = $Backcolor
$NumericUpDown.forecolor = $ForeColor
$NumericUpDown.Maximum = $Max
$NumericUpDown.Minimum = $Min
$NumericUpDown.Value = $InitialValue
$NumericUpDown.Increment = $Step
$NumericUpDown.DecimalPlaces = $Decimal
$NumericUpDown.ThousandsSeparator = $True
    
    return $NumericUpDown


<#
.SYNOPSIS

Create a NumericUpDown Object used for GUI.

.DESCRIPTION

Create a NumericUpDown Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)


.PARAMETER Width
NumericUpDown's Width

.PARAMETER Font 
NumericUpDown's Font

.PARAMETER FontSize 
NumericUpDown's FontSize

.PARAMETER FontStyle 
NumericUpDown's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the NumericUpDown in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the NumericUpDown in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the Numbers in the NumericUpDown. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the NumericUpDown's background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER Min 
NumericUpDown's minimal value

.PARAMETER InitialValue 
NumericUpDown's Initial Value if not the minimal 

.PARAMETER Max 
NumericUpDown's maximal value

.PARAMETER Step 
Increment/decrement value when Up/Down arrows are used

.PARAMETER Decimal 
Number of decimals displayed

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.NumericUpDown

.EXAMPLE

$MyParam_NumericUpDown = @{
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
$MyNumericUpDown = New-FormObjectNumericUpDownLight @MyParam_NumericUpDown
$Form.Controls.add($MyNumericUpDown)

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.NumericUpDown

#>    
    
    }

function New-FormObjectListBoxLight {
    param (
        [Parameter(Mandatory=$false)]
        [int]$Height = 50,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$Backcolor = 'White',

        [Parameter(Mandatory=$false)]
        [bool]$ScrollAlwaysVisible= $true,

        [Parameter(Mandatory=$false)]
        [bool]$MultiColumn=$false,

        [ValidateSet(0,1,2,3)]
        [Parameter(Mandatory=$false)]
        [int]$SelectionMode = 3,

        [Parameter(Mandatory=$false)]
        $Items
    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$listBox.Size = New-Object System.Drawing.Size($Width,$Height)
$listBox.ScrollAlwaysVisible = $ScrollAlwaysVisible
$listBox.Font= New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$listBox.backcolor = $Backcolor
$listBox.forecolor = $ForeColor
$listBox.MultiColumn = $MultiColumn
$listBox.SelectionMode = $SelectionMode 

$Items | ForEach-Object  {$listBox.items.Add($_)} | Out-Null
    
    return $listBox


<#
.SYNOPSIS

Create a listBox Object used for GUI.

.DESCRIPTION

Create a listBox Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Height
listBox's Height

.PARAMETER Width
listBox's Width

.PARAMETER Font 
listBox's Font

.PARAMETER FontSize 
listBox's FontSize

.PARAMETER FontStyle 
listBox's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the listBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the listBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the Numbers in the listBox. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the listBox's background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER ScrollAlwaysVisible 
Enable/disable ScrollBar

.PARAMETER MultiColumn 
Enable/disable a display on multiple columns

.PARAMETER SelectionMode 
Set the selectionmode : none, 1 item, multiItem, extended multiItem
see https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.selectionmode

.PARAMETER Items 
Array of items added to the listbox

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.listBox

.EXAMPLE

$MyParam_ListBox = @{
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
$MyListBox = New-FormObjectListBoxLight @MyParam_ListBox
$Form.Controls.add($MyListBox) 

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.listBox

#>    
    
    }


#=====================================================================================================
#=========================== Create and Add Object to a (sub-)Form ===================================
#=====================================================================================================
<#
    Objects are added directly to a form object
    Pro :
        Already added to a form, there is no need for a dedicated line of code to add them
    Con :
        Access to the object is boring
            Ex : ($Form.Controls | Where-Object {$_.Name -eq 'MyName' }).hide()
#>		

function Add-FormObjectLabelLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
		
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'regular',

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$Label = New-Object Windows.Forms.Label
$Label.Text = $Text
$Label.name = $name
$Label.Font = New-Object Drawing.Font($Font, $FontSize, [System.Drawing.FontStyle]($FontStyle))
$Label.AutoSize = $true
$Label.Location = New-Object Drawing.Point($LocationX,$LocationY)
$Label.ForeColor = $ForeColor

$Form.Controls.add($Label)


<#
.SYNOPSIS

Create a Label Object used for GUI and add it to a Previously created Form

.DESCRIPTION

Create a Label Object for Windows Display and add it to a Form (Windows.Forms.Form)
Light version with basics parameters.

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the label should be added

.PARAMETER name
Label's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Text
Label's Text

.PARAMETER Font 
Label's Font

.PARAMETER FontSize 
Label's FontSize

.PARAMETER FontStyle 
Label's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle
Example : 'italic,bold'

.PARAMETER LocationX 
Location of the label in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the label in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the characters's label. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
	$([System.Drawing.Color]::FromArgb(200,231,100,104))
	'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.label

.EXAMPLE

Add-FormObjectLabelLight -Form $MyForm -Name 'MyName' -text 'MyText' -LocationX 15 -LocationY 150

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyName' }).hide()

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyName' }).hide()

.LINK

https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.label

#>    
    
    }

function add-FormObjectLinkLabelLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,

        [Parameter(Mandatory=$true)]
        $url,

        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'regular',

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing


    $LinkLabel = New-Object Windows.Forms.LinkLabel

    #to pass the Variable on the add_click scope
    $LinkLabel | Add-Member -NotePropertyMembers @{CustomUrl = $url}
    $LinkLabel.add_Click({Start-Process $This.CustomUrl})


    $LinkLabel.Text = $text
    $LinkLabel.LinkColor = $ForeColor
    $LinkLabel.ActiveLinkColor = "RED"

    $LinkLabel.Font = New-Object Drawing.Font($Font, $FontSize, [System.Drawing.FontStyle]($FontStyle))
    $LinkLabel.AutoSize = $true
    $LinkLabel.Location = New-Object Drawing.Point($LocationX,$LocationY)
    $LinkLabel.Name = $name

    $Form.Controls.add($LinkLabel)


    <#
    .SYNOPSIS

    Create a LinkLabel Object used for GUI and add it to a Previously created Form.

    .DESCRIPTION

    Create a LinkLabel for Windows Display and add it to a Form (Windows.Forms.Form).
    Light version with basics parameters

    .PARAMETER Url
    Url used when the LinkLabel is clicked on

    .PARAMETER Form
    Form/Panel/Groupbox/Tab/... to which the LinkLabel should be added

    .PARAMETER name
    LinkLabel's Name.
    Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

    .PARAMETER Text
    LinkLabel's Text

    .PARAMETER Font 
    LinkLabel's Font

    .PARAMETER FontSize 
    LinkLabel's FontSize

    .PARAMETER FontStyle 
    LinkLabel's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle
    Example : 'italic,bold'

    .PARAMETER LocationX 
    Location of the LinkLabel in the form, on the X-Axis. Top Left is 0. Positive value expected

    .PARAMETER LocationY 
    Location of the LinkLabel in the form, on the Y-Axis. Top Left is 0. Positive value expected

    .PARAMETER ForeColor 
    Color of the LinkLabel's characters (link color).

    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.LinkLabel

    .EXAMPLE
    
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

    .LINK

    https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.linklabel

    #>    
        
}
function Add-FormObjectTextBoxLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,

        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [bool]$Multiline = $false,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$TextBox = New-Object System.Windows.Forms.textbox
$TextBox.Text = $Text
$TextBox.Multiline = $Multiline
$TextBox.Size = New-Object System.Drawing.Size($Width,$Height)
$TextBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$TextBox.Location = New-Object Drawing.Point($LocationX,$LocationY)
$TextBox.ForeColor = $ForeColor
$TextBox.name = $name
    
$Form.Controls.add($TextBox)


<#
.SYNOPSIS

Create a TextBox used for GUI and add it to a Previously created Form

.DESCRIPTION

Create a TextBox for Windows Display and add it to a Form (Windows.Forms.Form).
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the TextBox should be added

.PARAMETER name
TextBox's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Text
TextBox's Text

.PARAMETER Height
TextBox's Height

.PARAMETER Width
TextBox's Width

.PARAMETER Multiline
Allow/Disallow display on multiple lines

.PARAMETER Font 
TextBox's Font

.PARAMETER FontSize 
TextBox's FontSize

.PARAMETER FontStyle 
TextBox's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the TextBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the TextBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the TextBox's characters . See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

None.

.OUTPUTS

System.Windows.Forms.textbox

.EXAMPLE

add-FormObjectTextBoxLight     -Form $Form -Name 'My TextBox'	-text 'MyTextBox'

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyName' }).hide()

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyName' }).hide()

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.textbox

#>    
    
    }

function Add-FormObjectComboBoxLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
        
        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$true)]
        $Items, 

        [Parameter(Mandatory=$false)]
        [int]$SelectedIndex = 0

    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$ComboBox = New-Object system.Windows.Forms.ComboBox
$ComboBox.width = $Width
$ComboBox.autosize = $true
$ComboBox.location = New-Object System.Drawing.Point($LocationX,$LocationY)
$ComboBox.Size = New-Object System.Drawing.Size($Width,$Height)
$ComboBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$ComboBox.ForeColor = $ForeColor
# Add the items in the dropdown list
$Items  | ForEach-Object {[void] $ComboBox.Items.Add($_)}
# Select the default value
$ComboBox.SelectedIndex = $SelectedIndex
$ComboBox.name = $name
    
$Form.Controls.add($ComboBox)


<#
.SYNOPSIS

Create a ComboBox used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a ComboBox for Windows Display and add it to a Form (Windows.Forms.Form).
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the ComboBox should be added

.PARAMETER name
ComboBox's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Height
ComboBox's Height

.PARAMETER Width
ComboBox's Width

.PARAMETER Font 
ComboBox's Font

.PARAMETER FontSize 
ComboBox's FontSize

.PARAMETER FontStyle 
ComboBox's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the ComboBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the ComboBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the ComboBox's characters.
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER Items 
Array used to populate the ComboBox.

.PARAMETER SelectedIndex 
Index of the default item

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.ComboBox

.EXAMPLE

add-FormObjectComboBoxLight   -Form $Form -Name 'My ComboBox' -Items @('MyCombobox Item 0','BlaBla',2,3)

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyName' }).text



.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyName' }).text

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.combobox

#>    
    
    }

function Add-FormObjectButtonLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,

        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',
		
		[Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor = 'LightGray'

    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point($LocationX,$LocationY)
$Button.Size = New-Object System.Drawing.Size($Width,$Height)
$Button.Font=New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$Button.ForeColor = $ForeColor
$Button.BackColor = $BackColor
$Button.Text = $Text
$Button.name = $name

$Form.Controls.add($Button)

<#
.SYNOPSIS

Create a Button used for GUI.

.DESCRIPTION

Create a Button for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Text
Button's Text

.PARAMETER Height
Button's Height

.PARAMETER Width
Button's Width

.PARAMETER Font 
Button's Font

.PARAMETER FontSize 
Button's FontSize

.PARAMETER FontStyle 
Button's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the Button in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the Button in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER BackColor 
Color of the Button's Background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER ForeColor 
Color of the characters's Button. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'


.INPUTS

None.

.OUTPUTS

System.Windows.Forms.Button

.EXAMPLE

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

to add an action after clic
$Form.Controls |Where-Object {$_.Name -eq 'MyButton' }).Add_Click({
write-host "hello world"
	})


.EXAMPLE

add-FormObjectButtonLight -Form $Form -Name 'MyButton' -text 'Increment ProgressBar'

to add an action after clic
$Form.Controls |Where-Object {$_.Name -eq 'MyButton' }).Add_Click({
    write-host "hello world"
	})

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.button

#>    
    
    }

function Add-FormObjectProgressBarLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
		
        [Parameter(Mandatory=$false)]
        [int]$Height = 40,

        [Parameter(Mandatory=$false)]
        [int]$Width = 500,

        [Parameter(Mandatory=$false)]
        [int]$LocationX=20,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=20,

        [Parameter(Mandatory=$false)]
        [int]$Min=0,

        [Parameter(Mandatory=$false)]
        [int]$Max=100,

        [Parameter(Mandatory=$false)]
        [int]$InitialValue = $Min,

        [Parameter(Mandatory=$false)]
        [int]$Step=1,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Blue'
    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
  
$ProgressBar = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Location = New-Object System.Drawing.Point($LocationX, $LocationY)
$ProgressBar.Size = New-Object System.Drawing.Size($Width,$Height)
$ProgressBar.Style = 1
$ProgressBar.Minimum = $Min
$ProgressBar.Maximum = $Max
$ProgressBar.value = $InitialValue
$ProgressBar.Step = $Step
$ProgressBar.ForeColor = $ForeColor
        
$ProgressBar.name = $name
$Form.Controls.add($ProgressBar)
    
<#
.SYNOPSIS

Create a ProgressBar used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a ProgressBar for Windows Display and add it to a Form (Windows.Forms.Form).
Light version with basics parameters
Doesn't update itself alone : should use the method "PerformStep()" to increment the steps
No Label : use a label object 

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the ProgressBar should be added

.PARAMETER name
ProgressBar's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Height
ProgressBar's Height

.PARAMETER Width
ProgressBar's Width

.PARAMETER Min 
ProgressBar's minimal value

.PARAMETER InitialValue 
ProgressBar's Initial Value if not the minimal 

.PARAMETER Max 
ProgressBar's maximal value

.PARAMETER Step 
ProgressBar's step done when method "PerformStep()" is used

.PARAMETER LocationX 
Location of the ProgressBar in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the ProgressBar in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the ProgressBar's bar . See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.ProgressBar

.EXAMPLE

add-FormObjectProgressBarLight     -Form $Form -Name 'MyProgressBar'

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyName' }).hide()

    #Increment the progressbar
    for (($i = ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).Minimum); $i -lt ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).Maximum; ($i = ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).value))
    {
            ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).PerformStep()
            Sleep -Seconds 1
    }

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyName' }).hide()

    #Increment the progressbar
    for (($i = ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).Minimum); $i -lt ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).Maximum; ($i = ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).value))
    {
            ($Form.Controls |Where-Object {$_.Name -eq 'MyProgressBar' }).PerformStep()
            Sleep -Seconds 1
    }

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.progressbar

#>    
    
    }

function Add-FormObjectPictureBoxLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
        
        [Parameter(Mandatory=$true)]
        [string]$ImgFullPath,

        [Parameter(Mandatory=$false)]
        [decimal]$Ratio = 1,

        [Parameter(Mandatory=$false)]
        [int]$Height,

        [Parameter(Mandatory=$false)]
        [int]$Width, 

        [ValidateSet(0,1,2,3,4)]
        [Parameter(Mandatory=$false)]
        [int]$SizeMode = 1, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$file = (get-item $ImgFullPath -force)
$img = [System.Drawing.Image]::Fromfile($file);

$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$pictureBox.Image = $img

#If Width/Height not passed to the function, resize the image
if($Width -eq 0) {$Width = ($img.Width)*$Ratio}
if($Height -eq 0) {$Height = ($img.Height)*$Ratio}
$pictureBox.Size = New-Object System.Drawing.Size($Width,$Height)
$pictureBox.SizeMode = $SizeMode 

$pictureBox.name = $name
$Form.Controls.add($pictureBox)


<#
.SYNOPSIS

Create a PictureBox Object used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a PictureBox Object for Windows Display and add it to a Form (Windows.Forms.Form). 
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the PictureBox should be added

.PARAMETER name
PictureBox's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER ImgFullPath
FullPath of the image

.PARAMETER Ratio
AspectRatio of the Image (Height/Width).
Used when Height or Width is not passed to the function

.PARAMETER Height
Height used for the image. If not defined, image's Height is used, with an AspectRatio

.PARAMETER Width
Width used for the image. If not defined, image's Width is used, with an AspectRatio

.PARAMETER SizeMode
SizeMode for the image. 
See https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.pictureboxsizemode

.PARAMETER LocationX 
Location of the PictureBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the PictureBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.PictureBox

.EXAMPLE

$MyParam_PictureBox = @{
    Form = $Form
    Name = 'MyPictureBox'
	ImgFullPath = "$PSScriptRoot\Sample.png"
	Height =150
	Width = 100
    Ratio = 1
	SizeMode = 1
	LocationX = 20 
	LocationY = 350
}
add-FormObjectPictureBoxLight @MyParam_PictureBox

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyPictureBox' }).hide()

.EXAMPLE

add-FormObjectPictureBoxLight  -Form $Form -Name 'MyPictureBox' -ImgFullPath "$PSScriptRoot\Sample.png"

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'MyName' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'MyPictureBox' }).hide()

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.picturebox

#>    
    
    }

function Add-FormObjectRadioButtonLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
        
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My Radiobutton',

        [Parameter(Mandatory=$false)]
        [int]$Height = 50,

        [Parameter(Mandatory=$false)]
        [int]$Width = 50, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$false)]
        [bool]$Checked= $false


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$RadioButton = New-Object System.Windows.Forms.RadioButton
$RadioButton.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$RadioButton.Size = New-Object System.Drawing.Size($Width,$Height)
$RadioButton.Checked = $Checked
$RadioButton.text = $Text
$RadioButton.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$RadioButton.ForeColor = $ForeColor
    
$RadioButton.name = $name
$Form.Controls.add($RadioButton)



<#
.SYNOPSIS

Create a RadioButton used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a RadioButton for Windows Display and add it to a Form (Windows.Forms.Form).
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the RadioButton should be added

.PARAMETER name
RadioButton's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Text
RadioButton's Text

.PARAMETER Height
RadioButton's Height

.PARAMETER Width
RadioButton's Width

.PARAMETER LocationX 
Location of the RadioButton in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the RadioButton in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER Font 
RadioButton's Font

.PARAMETER FontSize 
RadioButton's FontSize

.PARAMETER FontStyle 
RadioButton's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER ForeColor 
Color of the RadioButton's characters . See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER Checked 
Default Checked State

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.radiobutton

.EXAMPLE

add-FormObjectRadioButtonLight -Form $Form -Name 'My MyRadioButton1' -Text 'MyRadioButton1'

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My MyRadioButton1' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My MyRadioButton1' }).hide()

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My MyRadioButton1' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My MyRadioButton1' }).hide()

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.radiobutton

#>    
    
    }

function Add-FormObjectCheckBoxLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
		
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My CheckBox',

        [Parameter(Mandatory=$false)]
        [int]$Height = 50,

        [Parameter(Mandatory=$false)]
        [int]$Width = 50, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$false)]
        [bool]$Checked= $false


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$CheckBox = New-Object System.Windows.Forms.CheckBox
$CheckBox.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$CheckBox.Size = New-Object System.Drawing.Size($Width,$Height)
$CheckBox.Checked = $Checked
$CheckBox.text = $Text
$CheckBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$CheckBox.ForeColor = $ForeColor
    
$CheckBox.name = $name
$Form.Controls.add($CheckBox)


<#
.SYNOPSIS

Create a CheckBox Object used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a CheckBox Object for Windows Display and add it to a Form (Windows.Forms.Form).
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the CheckBox should be added

.PARAMETER name
CheckBox's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Text
CheckBox's Text

.PARAMETER Height
CheckBox's Height

.PARAMETER Width
CheckBox's Width

.PARAMETER LocationX 
Location of the CheckBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the CheckBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER Font 
CheckBox's Font

.PARAMETER FontSize 
CheckBox's FontSize

.PARAMETER FontStyle 
CheckBox's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER ForeColor 
Color of the CheckBox's characters. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER Checked 
Default Checked State (T/F)

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.checkbox

.EXAMPLE


add-FormObjectCheckBoxLight -Form $Form -Name 'My CheckBox' -Text 'My CheckBox text'
to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My CheckBox' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My CheckBox' }).hide()

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My CheckBox' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My CheckBox' }).hide()

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.checkbox

#>    
    
    }

function Add-FormObjectCalendarLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,

        [ValidateSet("DatePicker", "MonthDisplayed")]
        [string]$Type = "DatePicker",

        [Parameter(Mandatory=$false)]
        [int]$Width = 150, 

        [Parameter(Mandatory=$false)]
        [int]$Height = 150, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

if ($Type -eq  "DatePicker") {   
    $Calendar = New-Object System.Windows.Forms.DateTimePicker}
    else {
    $Calendar = New-Object System.Windows.Forms.MonthCalendar
    }
$Calendar.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$Calendar.Width = $Width
$Calendar.Height = $Height
 
    
$Calendar.name = $name
$Form.Controls.add($Calendar)


<#
.SYNOPSIS

Create a Calendar Object used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a Calendar Object for Windows Display and add it to a Form (Windows.Forms.Form). 
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the Calendar should be added

.PARAMETER name
Calendar's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Type
Display a calendar with a date picker or a monthly calendar

.PARAMETER Width
Calendar's Width

.PARAMETER Height
Calendar's Height

.PARAMETER LocationX 
Location of the Calendar in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the Calendar in the form, on the Y-Axis. Top Left is 0. Positive value expected

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.DateTimePicker
or
System.Windows.Forms.MonthCalendar

.EXAMPLE

add-FormObjectCalendarLight -Form $Form -Name 'My Calendar' -type 'MonthDisplayed'

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My Calendar' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My Calendar' }).hide()

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My Calendar' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My Calendar' }).hide()

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.MonthCalendar

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.DateTimePicker

#>    
    
    }

function Add-FormObjectListViewLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
		
        [Parameter(Mandatory=$false)]
        [bool]$CheckBoxes =$false,

        [Parameter(Mandatory=$false)]
        [bool]$GridLines =$false,

        [Parameter(Mandatory=$true)]
        $MyColumns,

        [Parameter(Mandatory=$false)]
        [ValidateSet(0,1,2)]
        [int]$AutoResizeColumns = 0,

        [Parameter(Mandatory=$false)]
        $MyItems,

        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$Backcolor = 'White'


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$ListView = New-Object System.Windows.Forms.ListView
$ListView.View = [System.Windows.Forms.View]::Details
$ListView.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$Listview.Size = New-Object System.Drawing.Size($Width,$Height)
$Listview.Font= New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$Listview.CheckBoxes= $CheckBoxes
$Listview.GridLines= $GridLines
$Listview.backcolor = $Backcolor
$Listview.forecolor = $ForeColor

#Create My Columns
$MyColumns | ForEach-Object  {$ListView.Columns.Add($_[0],$_[1])} | Out-Null

# Add list items
Foreach ($MyItem in $MyItems) {
    $i =0
    foreach ($Item in $MyItem) {
        if ($i -eq 0) {
            $ListViewItem = New-Object System.Windows.Forms.ListViewItem($Item)
            $i++ } else {
            $ListViewItem.Subitems.Add($Item) | Out-Null
        }
    }
    $ListView.Items.Add($ListViewItem) | Out-Null
}
$ListViewItem = $null

$Listview.AutoResizeColumns($AutoResizeColumns) 
    
$Listview.name = $name
$Form.Controls.add($Listview)


<#
.SYNOPSIS

Create a Listview Object used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a Listview Object for Windows Display and add it to a Form (Windows.Forms.Form). 
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the Listview should be added

.PARAMETER name
Listview's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER CheckBoxes
Enable/Disable Checkboxes

.PARAMETER GridLines
Enable/Disable GridLines

.PARAMETER AutoResizeColumns
Resize columns, based on Header content, Columns content or No resizing
See https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.columnheaderautoresizestyle

.PARAMETER MyColumns
Array with Arrays containing Columns Header and Columns Size
See https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.listview.columnheadercollection.add

.PARAMETER MyItems
Array with Arrays (Items) containing value for each columns

.PARAMETER Width
Listview's Width

.PARAMETER Height
Listview's Height

.PARAMETER Font 
Listview's Font

.PARAMETER FontSize 
Listview's FontSize

.PARAMETER FontStyle 
Listview's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the Listview in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the Listview in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the Items's characters in the Listview. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the Listview's background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.ListView

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My ListView' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My ListView' }).hide()

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.ListView

#>    
    
    }

function Add-FormObjectDomainUpDownLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
		
        [Parameter(Mandatory=$false)]
        [string]$text,

        [Parameter(Mandatory=$false)]
        $MyItems,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$Backcolor = 'White'


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$DomainUpDown = New-Object System.Windows.Forms.DomainUpDown
$DomainUpDown.Width = $Width
$DomainUpDown.location = New-Object System.Drawing.Point($LocationX,$LocationY)
$DomainUpDown.Font= New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$DomainUpDown.backcolor = $Backcolor
$DomainUpDown.forecolor = $ForeColor
$DomainUpDown.text = $text

$MyItems | ForEach-Object  {$DomainUpDown.items.Add($_)} | Out-Null
    
$DomainUpDown.name = $name
$Form.Controls.add($DomainUpDown)


<#
.SYNOPSIS

Create a DomainUpDown Object used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a DomainUpDown Object for Windows Display and add it to a Form (Windows.Forms.Form). 
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the DomainUpDown should be added

.PARAMETER name
DomainUpDown's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER text
DomainUpDown's text displayed before selection

.PARAMETER MyItems
Array with Items to feed the DomainUpDown

.PARAMETER Width
DomainUpDown's Width

.PARAMETER Font 
DomainUpDown's Font

.PARAMETER FontSize 
DomainUpDown's FontSize

.PARAMETER FontStyle 
DomainUpDown's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the DomainUpDown in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the DomainUpDown in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the Items's characters in the DomainUpDown. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the DomainUpDown's background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.DomainUpDown

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My DomainUpDown' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My DomainUpDown' }).hide()

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.DomainUpDown

#>    
    
    }

function Add-FormObjectNumericUpDownLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
        
        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$Backcolor = 'White',

        [Parameter(Mandatory=$false)]
        [int]$Min=-100,

        [Parameter(Mandatory=$false)]
        [int]$Max=100,

        [Parameter(Mandatory=$false)]
        [int]$InitialValue = $Min,

        [Parameter(Mandatory=$false)]
        [decimal]$Step=1,

        [Parameter(Mandatory=$false)]
        [decimal]$Decimal=0


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$NumericUpDown = New-Object System.Windows.Forms.NumericUpDown
$NumericUpDown.Width = $Width
$NumericUpDown.location = New-Object System.Drawing.Point($LocationX,$LocationY)
$NumericUpDown.Font= New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$NumericUpDown.backcolor = $Backcolor
$NumericUpDown.forecolor = $ForeColor
$NumericUpDown.Maximum = $Max
$NumericUpDown.Minimum = $Min
$NumericUpDown.Value = $InitialValue
$NumericUpDown.Increment = $Step
$NumericUpDown.DecimalPlaces = $Decimal
$NumericUpDown.ThousandsSeparator = $True
    
$NumericUpDown.name = $name
$Form.Controls.add($NumericUpDown)


<#
.SYNOPSIS

Create a NumericUpDown Object used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a NumericUpDown Object for Windows Display and add it to a Form (Windows.Forms.Form). 
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the NumericUpDown should be added

.PARAMETER name
NumericUpDown's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Width
NumericUpDown's Width

.PARAMETER Font 
NumericUpDown's Font

.PARAMETER FontSize 
NumericUpDown's FontSize

.PARAMETER FontStyle 
NumericUpDown's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the NumericUpDown in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the NumericUpDown in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the Numbers in the NumericUpDown. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the NumericUpDown's background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER Min 
NumericUpDown's minimal value

.PARAMETER InitialValue 
NumericUpDown's Initial Value if not the minimal 

.PARAMETER Max 
NumericUpDown's maximal value

.PARAMETER Step 
Increment/decrement value when Up/Down arrows are used

.PARAMETER Decimal 
Number of decimals displayed

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.NumericUpDown

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My NumericUpDown' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My NumericUpDown' }).hide()

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.NumericUpDown

#>    
    
    }

function Add-FormObjectListBoxLight {
    param (
        [Parameter(Mandatory=$true)]
        $Form,

        [Parameter(Mandatory=$true)]
        [string]$name,
		
        [Parameter(Mandatory=$false)]
        [int]$Height = 50,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$Backcolor = 'White',

        [Parameter(Mandatory=$false)]
        [bool]$ScrollAlwaysVisible= $true,

        [Parameter(Mandatory=$false)]
        [bool]$MultiColumn=$false,

        [ValidateSet(0,1,2,3)]
        [Parameter(Mandatory=$false)]
        [int]$SelectionMode = 3,

        [Parameter(Mandatory=$false)]
        $Items
    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$listBox.Size = New-Object System.Drawing.Size($Width,$Height)
$listBox.ScrollAlwaysVisible = $ScrollAlwaysVisible
$listBox.Font= New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$listBox.backcolor = $Backcolor
$listBox.forecolor = $ForeColor
$listBox.MultiColumn = $MultiColumn
$listBox.SelectionMode = $SelectionMode 

$Items | ForEach-Object  {$listBox.items.Add($_)} | Out-Null
    
$listBox.name = $name
$Form.Controls.add($listBox)


<#
.SYNOPSIS

Create a listBox Object used for GUI and add it to a Previously created Form.

.DESCRIPTION

Create a listBox Object for Windows Display and add it to a Form (Windows.Forms.Form). 
Light version with basics parameters

.PARAMETER Form
Form/Panel/Groupbox/Tab/... to which the listBox should be added

.PARAMETER name
listBox's Name.
Usefull to get the object, like this : $Form.Controls |Where-Object {$_.Name -eq 'MyName' }

.PARAMETER Height
listBox's Height

.PARAMETER Width
listBox's Width

.PARAMETER Font 
listBox's Font

.PARAMETER FontSize 
listBox's FontSize

.PARAMETER FontStyle 
listBox's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the listBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the listBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the Numbers in the listBox. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the listBox's background. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(255,200,200,200))
'Red'

.PARAMETER ScrollAlwaysVisible 
Enable/disable ScrollBar

.PARAMETER MultiColumn 
Enable/disable a display on multiple columns

.PARAMETER SelectionMode 
Set the selectionmode : none, 1 item, multiItem, extended multiItem
see https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.selectionmode

.PARAMETER Items 
Array of items added to the listbox

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.listBox

.EXAMPLE

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

to access object : 
$Form.Controls |Where-Object {$_.Name -eq 'My ListBox' }
Ex : ($Form.Controls |Where-Object {$_.Name -eq 'My ListBox' }).hide() 

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.listBox

#>    
    
    }


#=====================================================================================================
#============================================= Others ================================================
#=====================================================================================================

function Show-MessageBox { 
    #source : https://stackoverflow.com/questions/59371640/powershell-popup-in-form
        [CmdletBinding()]
        param(
            [parameter(Mandatory = $true, Position = 0)]
            [string]$Message,
    
            [parameter(Mandatory = $false)]
            [string]$Title = 'MessageBox in PowerShell',
    
            [ValidateSet("OKOnly", "OKCancel", "AbortRetryIgnore", "YesNoCancel", "YesNo", "RetryCancel")]
            [string]$Buttons = "OKCancel",
    
            [ValidateSet("Critical", "Question", "Exclamation", "Information")]
            [string]$Icon = "Information"
        )
        Add-Type -AssemblyName Microsoft.VisualBasic
    
        [Microsoft.VisualBasic.Interaction]::MsgBox($Message, "$Buttons,SystemModal,$Icon", $Title)
    }
    
    function Show-Notification{
        param(
            [parameter(Mandatory = $true)]
            [string]$Txt,
    
            [parameter(Mandatory = $true)]
            [string]$Title = 'Notification from PowerShell'
        )
        Add-Type -AssemblyName System.Windows.Forms
        $global:balmsg = New-Object System.Windows.Forms.NotifyIcon
        $path = (Get-Process -id $pid).Path
        $balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
        $balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
        $balmsg.BalloonTipText = "$Txt"
        $balmsg.BalloonTipTitle = "$Title"
        $balmsg.Visible = $true
        $balmsg.ShowBalloonTip(0)
    
    <#
    .SYNOPSIS
    
    Show a Windows Notification
    
    .DESCRIPTION
    
    Show a Windows Notification
    
    .PARAMETER Txt
    Displayed text
    
    .PARAMETER Title
    Displayed Title
    
    
    .INPUTS
    
    None.
    
    .OUTPUTS
    
    System.Windows.Forms.NotifyIcon
    
    .EXAMPLE
    
    Show-Notification -Txt "Hello World" -Title "My title"
    
    .LINK
    
    https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.NotifyIcon
    
    #>    
    }
    
    #If an input is needed, without an exhaustive form, use Out-GridView
    #Example
    #'one','two','three','four' | Out-GridView -OutputMode Single
    