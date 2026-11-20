### TK-POP

#### Pop-Up Menus and Message Boxes

**Description**

The TK-POP pop-up menu provides the programmer with a quick means for creating menus or messages to be displayed on the terminal. These menus are dynamic in nature, that is they adjust their size to the size of the list, and they may be positioned anywhere on the screen.

Examples:

![]([docs/TK-1-TKPOP-1.GIF](https://github.com/aa-87/TK-POP/blob/main/docs/TK-1-TKPOP-1.gif))

TK-POP provides 4 basic types of displays:

> o Single and multi-column menus  
> o Multiple selection menus  
> o Dialog box  
> o Message box

TK-POP may receive 6 types of response from the user:

> o Carriage Return  
> o Cursor keys  
> o Alphanumeric keys  
> o Next/Previous/First Screen Function keys  
> o User selectable Function keys  
> o Space bar

**Routines**

* * *

^TKPOP,^TKPOP1,^TKPOPDOC

**Globals**

* * *

None created. May reference user globals for data.

**Preparation**

* * *

Y needs to be defined before calling. X and Y(0) are optional parameters that may also be defined.

**Use**

* * *

To use the pop-up menus, the user must first setup special parameter strings instructing TK-POP how it is to be displayed on the screen. Generally only the Y string need be defined, but additional capabilities are provided when the the Y(0) and X strings are also defined. See the tables below for the definition of each of these variables as well as the optional flags:

**Y VARIABLE DEFINITIONS (using \\ as delimiter)**

**Piece**

**Descr.**

**Use**

1

Column \[,ROW\]

Specifies left column of pop-up. Use the optional row value to define the top row, otherwise it will position automatically at the top or bottom.

2

Flags

Defines look and feel of pop-up. See the table below for a list of the flags.

3

\# Columns

Defines the number of columns to be displayed. TK-POP will scale the number of columns back if they will not all fit on the screen.

4

Title

If this piece is present, then the contents will be displayed on the top line of the pop-up. Append an "\*" for Reverse Video.

5

Column Heading

Provides the option to display a heading on the top of each column. The heading will be underlined and will define the column width if it is longer than the data.

6

Data

Lists each of the items to be displayed in the menu. Each item is separated by a comma, and items followed by a "\*" will be displayed but not selectable. Blank lines can be created by including "\*" as data items. Note that the data may also be stored in the Y array (use the Y flag) or may come from any other local or global variable (use piece 3 in Y(0)). A single "\*" will create blank lines.

**TK-POP FLAGS (as used in Piece 2 of Y)**

**Flag**

**Descr.**

**Use**

A

Advance

Causes cursor to advance to the next item when selecting in a MULTIPLE.

B

Bottom

The pop-up starts from the bottom of the screen.

C

Current Row

The current value of %R will define the top of the pop-up. (%R must be defined.)

D

Display

Leaves the pop-up on the screen after the user makes the selection. It is up to the application software to clear.

H

High Intensity

Displays the pop-up in high intensity video. The default is low intensity.

L

Line Border

Provides lines around the pop-up.

M

Multiple

Allows the user to select one or more entries in the menu. The SELECT function key is used to toggle individual entries on or off. Selected items will be highlighted. X will be returned with each selected item separated by a comma.

Ox

Override Asterisk

Allows another ASCII character to be used to signal "display only" items. Follow O with ASCII value.

Px

Pad Columns

Allows the user to add additional space to each column. Specify the number of spaces directly after the "P".

Q

Quick Mode

Return not required.

R

Reverse Video

Displays pop-up in reverse video (high or low intensity depending upon the use of the H parameter).

S

Subscript

Instructs TK-POP to return in the X variable the subscript value of the selected item(s) rather than the positional value (1-x). This is most useful when using the GLOBAL option. (If the MULTIPLE option is used, the subscripts will be found in the X array).

T

Top

Specifies that the menu be displayed top down.

U

Uppercase

Forces uppercase.

V

Value

TK-POP will return the displayed text in the X variable rather than the position. (If the MULTIPLE option is used, then the displayed values will be returned in the X array.)

W

Write only

The menu is written to the screen and control is returned to the calling routine. No selections may be made. Use Wxx to erase the menu after xx number of seconds. The user may scroll through multiple pages when timeout is specified.

Y

Y array

Enter a Y if the options of the menu are stored in Y(1), Y(2),...Y(n) rather than the 6th piece of the Y variable or the global (if Y(0) piece 4 is defined).

**Y(0)**

Additional capabilities can be specified for TK-POP in the Y(0) local variable. In particular, these capabilities extend the menus to be able to accomodate function keys, user defined lists and special formating features such as transforms, page limits and variable starting positions. The following table provides a listing of each of the parameters that may be specified:

**Y(O) VARIABLE DEFINITIONS (using \\ as delimiter)**

**Piece**

**Descr.**

**Use**

1

Count

Specifies the count of items in Y() to save TK-POP from having to compute it. This piece may also be used to limit the number of items displayed on one menu.

2

Function

Allows TK-POP to terminate on function keys and selects the particular function keys that will be active. (See Appendix C for a list of function key mnemonics).

3

Alternate

Defines an alternate variable to use for the list of items List that are displayed in the menu. This may be a local or global reference and can contain subscripts, i.e. ^TXT("A").

4

Transform

The data displayed in the menu may be altered with any MUMPS code that is found in this piece. The variable TO is the current subscript value of the displayed item. Examples: TO\_" "\_^TEXT(TO) or $P(^TEXT("ABC","^",3) Columns can be created using the following syntax: reference

5

Starting Point

If an alternate list is specified (piece 3 of Y(0)), and the display of the list is to start somewhere other than the beginning, the starting point should be specified here.

6

Bottom Line

The contents of this piece will be displayed on the bottom line of the menu. If any paging is required, this message will preclude any paging messages that TK-POP will generate. An asterisk can be inserted in this message so that TKPOP can insert the "NEXT" and "PREVIOUS" messages in the user's message.

7

Cursor Position

The initial cursor position of TK-POP may be specified by including the position value 1-x (or the subscript if the Alternate List option is used). If a value greater than any value in the list is used, then the cursor will be positioned on the last line of the last page of the menu.

8

Ending

If an alternate list is specified (piece 3 of Y(0)), and the display of the list is to end at some point other than the actual end of the list, the last displayable value should be specified here. (String comparisons assumed)

9

Timeout

Specifies the number of seconds before TKPOP times out.

**Function Keys**

Piece 2 of Y(0) allows function keys to be specified as terminators of the menu. This means that the user may use any one of the specifed function keys as well as the normal RETURN key to terminate the TK-POP. See Appendix C for a list of function key mnemonics to be used (separate more than one with a comma).

**X**

The user's selection is passed back through the variable X. If the first option is selected, then X = 1, the second, X = 2, and so on. Note that items that contain an "\*" are not selectable by the user but still take a place on the menu and still count in the X value that is returned.

Variations of the returned values in X come about when any of the following options are used:

Function keys - The terminating function key mnemonic is returned in the second piece of X with a ";" as the delimiter

Subscript or Value flags - The position value is replaced with either the Subscript or Display value of the selected item.

Multiples - The X value become both an input and an output variable. On input to TK-POP X provides a list items that will be "pre-selected" in the menu. Each item is separated with a comma. On output, TK-POP returns the selected values in X, each separated with a comma (with a trailing comma present). Note that this list may also contain items that were "pre-selected" and that were not de-selected by the user. Using the "S" or "V" flags along with a multiple selection will create an X array to be defined with the corresponding subscript or display values.

An indirect use of the X array on input is to cause certain items to be displayed in high or low intensity. Setting X(x)="" for the appropriate positions will alter how that line is displayed in the pop-up.

X may be "predefined" and displayed when using TK-POP as a dialog box.

**Examples**

An example of how you would use TK-POP in one of your routines might look like this:

![](TK-1-TKPOP-2.GIF)

The value of X returned from the above pop-up is either 1, 2 or 3. The program then jumps with a computed GOTO to either TODAY, YEST or TOMOR.

TK-POP can also be used to create a simple data entry box, or what is sometimes called a dialog box. To do this, you must not include any menu items in Piece 6 or the Y array, but you can include as many heading lines that you wish. TK-POP will then call TK-READ with the cursor positioned at the end of the last heading line. An example of the Y variable for a dialog box would look like:

![](TK-1-TKPOP-3.GIF)

Note that when using TK-POP as a dialog box, you may also define any of the TK-READ variables such as PAT, MIN, MAX, TRM and CHR if you want more control over the input (see TK-READ).

For a more complex example of TK-POP, the following illustrates the use of the GLOBAL option as well a starting point and transform. Also the count value limits the number of words that are initially displayed so that pop-up doesn't take up the entire screen.

![](TK-1-TKPOP-4.GIF)

The variable TO is used in the transform to indicate to TK-POP to display the subscripts of the global ^TKWORD rather than the data. The function keys EXIT and OTHER OPTIONS are activated so that the user can jump out of the pop-up without making a selection.
