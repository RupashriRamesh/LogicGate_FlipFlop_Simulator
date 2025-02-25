package require Tk

# Variables
set mode_var "Logic Gate"
set input_var ""
set output_var "Result will appear here"

# Validate binary input
proc validate_binary_input {val} {
    return [regexp {^[01]$} $val]
}

# Process Logic Gates
proc process_logic_gate {logic a b} {
	global error
    array set logic_gates {
        "AND"  {expr {$a && $b}}
        "OR"   {expr {$a || $b}}
        "NAND" {expr {!($a && $b)}}
        "NOR"  {expr {!($a || $b)}}
        "XOR"  {expr {$a ^ $b}}
        "XNOR" {expr {!($a ^ $b)}}
        "NOT"  {expr {!$a}}
    }

    if { ![info exists logic_gates($logic)] } {
        set error 1
        return "Error: Invalid logic gate!"
    }

    if { $logic == "NOT" } {
        if { $b != "" || $a == ""} {
	    set error 1
            return "Error: NOT gate requires exactly 1 input!"
        }
        if { ![validate_binary_input $a] } {
	    set error 1
            return "Error: Enter only binary input (0 or 1)"
        }
	set error 0
        return [eval $logic_gates($logic)]
    }

    if { $b == "" || $a == "" } {
	set error 1
        return "Error: $logic gate requires 2 inputs (a b)"
    }

    if {![validate_binary_input $a] || ![validate_binary_input $b]} {
	set error 1
        return "Error: Invalid input! Use binary (0 or 1)"
    }
    set error 0
    return [eval $logic_gates($logic)]
}

# Process Flip-Flops
proc process_flip_flop {FF q a b} {
	global error
    array set Flip_Flops {
        "SR" {expr {$a || ($q && !$b)}}
        "JK" {expr {(!$q && $a) || ($q && !$b)}}
        "D"  {expr {$a}}
        "T"  {expr {$q ^ $a}}
    }

    if { ![info exists Flip_Flops($FF)] } {
	set error 1
        return "Error: Invalid Flip-Flop!"
    }

    if { ($FF == "D" || $FF == "T") && ($b != "" || $a == "") } {
	set error 1
        return "Error: $FF Flip-Flop requires exactly 2 inputs (q $FF)."
    }

    if { ($FF == "SR" || $FF == "JK") && $b == "" } {
	set error 1
        return "Error: $FF Flip-Flop requires exactly 3 inputs (q [string index $FF 0] [string index $FF 1])."
    }

    if { ![validate_binary_input $q] || ![validate_binary_input $a] || ($b != "" && ![validate_binary_input $b]) } {
	set error 1
        return "Error: Enter only binary values (0 or 1)"
    }
    set error 0
    return [eval $Flip_Flops($FF)]
}

# Evaluate Input
proc evaluate_input {} {
    global mode_var input_var output_var error
    set lst [split [string trim $input_var] " "]
    set len [llength $lst]
    
    # Extracting inputs
    set gate [string toupper [lindex $lst 0]]
    set a [lindex $lst 1]
    set b [lindex $lst 2]
    set c [lindex $lst 3]
    if {$input_var eq ""} {
    set output_var "Error: Please enter a valid input!"
    return
}

    # Input length validation
    if {$mode_var == "Logic Gate"} {
        if { $len > 3 } {
            set output_var "Error: Logic Gate requires 1 or 2 binary inputs!"
            return
        }
        set result [process_logic_gate $gate $a $b]
    } else {
        if { $len > 4 } {
            set output_var "Error: Flip-Flop requires exactly 2 or 3 inputs!"
            return
        }
        set result [process_flip_flop $gate $a $b $c]
    }

    # Display output
    if {$error == 1} {
        set output_var "$result"
    } else {
        set output_var "Output = $result"
    }
}

# GUI
wm title . "Logic & Flip-Flop Simulator"

frame .top_frame
label .top_frame.lbl -text "Select Mode: "
set mode_var "Logic Gate"
tk_optionMenu .top_frame.menu mode_var "Logic Gate" "Flip-Flop"
pack .top_frame.lbl .top_frame.menu -side left -padx 5
pack .top_frame -padx 10 -pady 10

frame .input_frame
set input_label_text "Enter Input (e.g., AND 1 0 ):"
label .input_frame.lbl -textvariable input_label_text
entry .input_frame.entry -textvariable input_var -width 40
button .input_frame.btn -text "Evaluate" -command evaluate_input
pack .input_frame.lbl .input_frame.entry .input_frame.btn -side left -padx 5
pack .input_frame -padx 10 -pady 10

label .output_lbl -textvariable output_var -font "Arial 12 bold"
pack .output_lbl -padx 10 -pady 5

# Procedure to update label based on selection
proc update_label {varname index op} {
    global mode_var input_label_text
    if {$mode_var == "Logic Gate"} {
        set input_label_text "Enter Input (e.g., AND 1 0 ):"
    } else {
        set input_label_text "Enter Input (e.g., SR 1 0 0 ):"
    }
}

# Attach a trace to mode_var to call update_label whenever mode_var changes
trace add variable mode_var write update_label
