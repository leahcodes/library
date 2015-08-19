require('spec_helper')

describe(Author) do

  describe('.all') do
    it('makes an empty array to store authors in') do
      expect(Author.all()).to(eq([]))
    end
  end




#   describe('#id') do
#     it("sets the ID when the author is saved") do
#       author = Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
#       author.save()
#       expect(author.id()).to(be_an_instance_of(Fixnum))
#     end
#   end
end
