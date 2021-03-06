workspace = undefined
editor = ace.edit("editor")
editor.getSession().setUseSoftTabs false
editor.getSession().setMode 'ace/mode/python'

exo1 = 
  titre  : "Boucle While"
  enonce : "Jean a mis en banque en 2012 un capital de 600 euros. Chaque année, il rajoute 76 euros sur ce compte. En quelle année dépassera-t-il les 1000€ ?"
exo2 = 
  titre  : "Boucle While (avec appel de fonction)"
  enonce : "Jean a mis en banque en 2012 un capital de 600 euros. Chaque année, il rajoute 76 euros sur ce compte. En quelle année dépassera-t-il les 1000€ ?"
exo3 = 
  titre  : "Boucle For"
  enonce : "Jeanne a mis en banque en début d’année un capital de 1500 euros. Chaque année, son capital est multiplié par 1,02. Dans 6 ans, de quelle somme disposera-t-il ?"
exo4 = 
  titre  : "Boucle For (avec appel de fonction)"
  enonce : "Jeanne a mis en banque en début d’année un capital de 1500 euros. Chaque année, son capital est multiplié par 1,02. Dans 6 ans, de quelle somme disposera-t-il ?"

$ ->
  $.ajax
    type: "GET"
    url: "xml/exo3-toolbox.xml"
    dataType: "xml"
    success: (xml) ->
      workspace = Blockly.inject 'blocklyDiv',
        media: "js/vendor/blockly/media/"
        zoom:
          controls: true
          wheel: true
          startScale: 1.1
          maxScale: 3
          minScale: 0.5
          scaleSpeed: 1.2
        toolbox: $(xml).find("#toolbox")[0]
      Blockly.Msg.VARIABLES_SET = 'mettre %2 dans %1'
      Blockly.Msg.TEXT_JOIN_TITLE_CREATEWITH = 'regrouper'
  
  # Toggle Blockly / Python
  divsPython  = "#pythonMode,  #boutons_editor"
  divsBlockly = "#blocklyMode, #boutons_blockly, .blocklyToolboxDiv"
  
  $( ".toggleModetoB" ).on "click", ->  
    $( divsPython ).hide()
    $( divsBlockly).toshow()
    $( "#pythonTutor" ).hide().attr "src", ""
    
  
  $( ".toggleModetoE" ).on "click", ->  
    $( divsPython ).show()
    $( divsBlockly).hide()
    texte = getPythonText()
    editor.setValue tabuler(texte), -1
    editor.focus()
    
  # Blockly events
  $( "#runBlocks"  ).on "click", -> runBlockly()
  $( "#saveBlocks" ).on "click", -> sauverFichier()
  $( "#openBlocks" ).on "click", -> ouvrirClick()
  $( "#fileToLoad" ).on "change",-> ouvrirFichier()
  
  # Python events
  $( "#executer"  ).on  "click", -> runPython(editor)
  $( "#sauverFichierEdit" ).on "click",  -> sauverFichierEdit(editor)
  $( "#ouvrirClickEdit"   ).on "click",  -> ouvrirClickEdit()
  $( "#fileToLoadEdit"    ).on "change", -> ouvrirFichierEdit()
  
  # Charger un fichier blockly depuis le repertoire xml/name.xml
  loadSample = (name, exo) ->
    $( divsPython ).hide()
    $( divsBlockly).show()
    $( "#enonce h2" ).html exo.titre
    $( "#enonce p" ).html exo.enonce
    $( "#enonce").show()
    $( "#pythonTutor" ).hide().attr "src", ""
    workspace.clear()
    $.ajax
      type: "GET"
      url: "xml/#{name}.xml"
      dataType: "xml"
      success: (xml) -> 
        Blockly.Xml.domToWorkspace $(xml).find("##{name}")[0], workspace
    
  $( "#d0" ).on "click", -> loadSample( "seuil0", exo1 )
  $( "#d1" ).on "click", -> loadSample( "seuil1", exo2 )
  $( "#d2" ).on "click", -> loadSample( "seuil2", exo3 )
  $( "#d3" ).on "click", -> loadSample( "seuil3", exo4 )
  
  # Afficher un message dans output
  Println '> 1) Il y a quelques exemples Blockly à tester...'
  Println '> 2) Pour passer de Blockly à Python, cliquez sur le bouton Editeur...'
  
  $( "#pythonTutorGo" ).on "click", ->
    beforeURI ="http://pythontutor.com/iframe-embed.html#code="
    code = encodeURIComponent(escape(editor.getValue())).replace(/%25/g, "%")
    afterURI = "&codeDivHeight=400&codeDivWidth=350&cumulative=false&curInstr=0&heapPrimitives=false&origin=opt-frontend.js&py=3&rawInputLstJSON=%5B%5D&textReferences=false"
    uri = beforeURI + code + afterURI
    console.log uri
    $( "#pythonTutor" ).show().attr "src", uri
    
  
    
    
    
    
    
    
