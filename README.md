  The simple description of the workflow is as follows (in Web-editor):
On use of plugin:
   (if first use: generate grammar)
   use grammar to parse input (request from MMT to perl/Marpa)
   position information is returned to MMT and processed/displayed in javascript
   user feedback from generated suggestions 
   request to MMT to perform replacement (generate content math ml)
   web editor content changed (the original input and content math ml 
   are used to create parallel markup)