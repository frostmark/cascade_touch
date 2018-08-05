RSpec.describe CascadeTouch do
  describe '.call' do
    let(:schema) do
      {
        user: {
          books: {
            genre: {},
            author: {}
          }
        }
      }
    end

    let!(:user) { User.create }
    let!(:book) { Book.create(users: [user]) }
    let!(:second_book) { Book.create(users: [user]) }
    let!(:genre) { Genre.create(books: [book]) }
    let!(:author) { Author.create(books: [book]) }

    let(:other_time) { Time.current - 2.hours }

    before do
      book.update_attribute(:updated_at, other_time)
      genre.update_attribute(:updated_at, other_time)
      author.update_attribute(:updated_at, other_time)
      second_book.update_attribute(:updated_at, other_time)
    end

    it 'updates models in chain' do
      described_class.call('User', user.id, schema)

      expect(book.reload.updated_at).to eql(user.updated_at)
      expect(genre.reload.updated_at).to eql(user.updated_at)
      expect(author.reload.updated_at).to eql(user.updated_at)
      expect(second_book.reload.updated_at).to eql(user.updated_at)
    end
  end
end
