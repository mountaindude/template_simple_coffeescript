template_path = Qva.Remote + "?public=only&name=Extensions/template_simple_coffeescript/"

extension_Init = ->
	# Use QlikView's method of loading other files needed by an extension. These files should be added to your extension .zip file (.qar)
	if typeof jQuery == 'undefined'
	    Qva.LoadScript(template_path + 'jquery.js', extension_Done)
	else
	    extension_Done()

		
extension_Done = ->
	# Add extension
	Qva.AddExtension('template_simple_coffeescript', ->
		_this = this

		# add a unique name to the extension in order to prevent conflicts with other extensions.
		# basically, take the object ID and add it to a DIV
		divName = _this.Layout.ObjectId.replace("\\", "_")
		if _this.Element.children.length == 0 
			# if this div doesn't already exist, create a unique div with the divName
			ui = document.createElement("div")
			ui.setAttribute("id", divName)
			_this.Element.appendChild(ui)
		else
			# if it does exist, empty the div so we can fill it again
			$("#" + divName).empty()
			
		# create a variable to put the html into
		html = ""
		# set a variable to the dataset to make things easier 
		td = _this.Data
		# loop through the data set and add the values to the html variable
		for rowIx in [0..(td.Rows.length-1)]
			# set the current row to a variable
			row = td.Rows[rowIx]
			# get the value of the first item in the dataset row
			val1 = row[0].text
			# get the value of the second item in the dataset row
			m = row[1].text
			# add those values to the html variable
			html += "value 1: " + val1 + " expression value: " + m + "<br />"

		# insert the html from the html variable into the extension.
		$("#" + divName).html(html)
	)


# Initiate extension
@extension_Init()

