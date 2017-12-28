module ListsHelper
  def list_type(list, klass)
    opener = list.ordered ? %^<ol class="#{klass}">^ : %^<ul class="#{klass}">^
    closer = list.ordered ? %^</ol>^ : %^</ul>^
    yield block
  end
end
