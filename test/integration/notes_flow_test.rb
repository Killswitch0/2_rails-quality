require "test_helper"

class NotesFlowTest < ActionDispatch::IntegrationTest
  # паттерн 'транзакционное тестирование' - данные загружаются в базу,
  # затем происходят действия, которые вы ожидаете в тесте, после чего rollback-транзакция
  # все это откатывает. Данные в базе не сохраняются, после каждого теста откатываются.
  # self.use_transactional_tests = true    смотри в test/test_helper.rb

  # test "the truth" do
  #   assert true
  # end

  # В данном случае тест работает так:
  # идет внутренний запрос к серверу, возвращается в текстовом виде страница
  # и в ней тест проверяет то, что нужно
  test 'opens all notes page' do
    # запрос на корневую директорию
    get root_path

    # должен вернуть нам success
    assert_response :success
    # в отрендеренной страничке должен быть тэг h1, который содержит Notes
    assert_select 'h1', 'Notes'
  end

  test 'opens one note page' do
    # note = Note.create(
    #     title: 'Title 1',
    #     description: 'Description 1'
    # )

    # В тестировании исп-тся понятие 'изолированный запуск' - каждый тест должен
    # запускаться из чистого окружения, с нулевыми данными, а все данные должны
    # генерироваться специально для него
    get note_path(notes(:note_1))

    assert_response :success

    assert_select 'h1', 'Note page'
    assert_select 'p', 'Title 1'
    assert_select 'p', 'Description 1'
  end
end
