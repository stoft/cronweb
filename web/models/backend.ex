defmodule Cronweb.Backend do
  @backend_name :agent_backend

  # Client API

  def get(document_id) do
    Agent.get(@backend_name, &HashDict.get(&1, document_id))
  end

  def get() do
    IO.inspect Agent.get(@backend_name, &HashDict.values(&1))
  end
  

  def insert(document, id_field_name) when is_atom(id_field_name) do
    id = Crypto.unique_id
    doc = Map.put document, id_field_name, id
    :ok = Agent.update(@backend_name, &HashDict.put(&1, id, doc))
    id
  end

  def insert(document, id_field_name) do
    insert(document, String.to_atom(id_field_name))
  end
  
  def update(document, id) do
    Agent.update(@backend_name, &HashDict.put(&1, id, document))
  end

  def delete(document_id) do
    Agent.get_and_update(@backend_name, &HashDict.pop(&1, document_id))
  end
  
  ##-------------------------------------------------
  ## Server/Agent Callbacks
  ##-------------------------------------------------

  def start_link do
    Agent.start_link(fn -> HashDict.new end, [name: @backend_name])
  end

end