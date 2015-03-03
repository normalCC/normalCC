
  def self.search(search)
    if search
      self.where("title iLIKE ?", "%#{search}%")
    else
      self.all
    end
  end

  def self.not_time(parts)
      if parts
        where.not("title @@ :s", s: parts )
      end
  end
  
  def self.time_search(words)
    if words
      where("title @@ :s", s: words )
    end
  end

  def self.text_search(query) 
    if query
      
      where("title @@ :s or title @@ :q", q: "%#{query}%", s: "%#{query}%" )
    else
      render 'new'
    end
  end