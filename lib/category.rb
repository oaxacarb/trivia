class Category
    def current(position)
        categories[position % 4]
    end
    
    private
    
    def categories
        %w[Pop Science Sports Rock]
    end
end