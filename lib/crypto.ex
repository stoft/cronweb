defmodule Crypto do
	def sha256(str) do
		Base.encode64(:crypto.hash(:sha256, str))
	end

  def sha1_base16(str) do
    Base.encode16(:crypto.hash(:sha, str))
  end
  

  @doc """
  Create a random identifying integer,
  returning its string representation in base 16.

  Based on this Erlang function:
  http://www.christopherbiscardi.com/2013/01/12/riak-core-unique-identifiers/

  Disclaimer: I don't know what I'm doing
  """
  @spec unique_id() :: String.t
	def unique_id() do
    :erlang.term_to_binary({make_ref(), :os.timestamp()})
    |> sha1_base16
	end
	
end