class Shake
  
  def Shake::supplant template_path, file_path, hash
    
    #read template
    template = IO.read( template_path )
    
    #supplant hash
    hash.each { | key, value |
        template = template.gsub( key, value )
    }
    
    #save file
    File.open( file_path, 'w' ) { |f| f.write template }
  end
  
end