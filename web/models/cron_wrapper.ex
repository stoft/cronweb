defmodule Cronweb.CronWrapper do

  @spec start_cron_job(String.t, String.t, String.t) :: {:ok, pid()} | {:error, any}
  def start_cron_job(id, cron_string, command) do
    schedule = {:cron, parse_cron_string(cron_string)}
    mfargs = {&__MODULE__.trigger_job/2, [id, command]}
    :leader_cron.schedule_task(id, schedule, mfargs)
  end

  def stop_cron_job(id) do
    :leader_cron.cancel_task(id)
  end

  def trigger_job(id, command) do
    IO.puts "Job #{id} triggered with command: #{command}"
  end

  def valid?(cron_string) do
    is_tuple(parse_cron_string(cron_string))
  end
  
  
  def parse_cron_string(cron_string) do
    cron_string
    |> String.split
    |> convert_tokens
  end

  defp convert_tokens(tokens) when length(tokens) == 5 do
    tokens    
    |> Enum.map(&translate_token(&1))
    |> List.to_tuple
  end

  defp convert_tokens(_), do: raise InvalidNumberOfTokensError

  defp translate_token("*"), do: :all
  defp translate_token(token) do
    cond do
      String.match?(token, ~r/\d+-\d+/) ->
        translate_token(:range, token)
      String.match?(token, ~r/(\d+,)+\d+/) ->
        translate_token(:list, token)
      String.match?(token, ~r/\d+/) -> translate_token(:num, token)
      true -> raise InvalidTokenError
    end
  end

  defp translate_token(:range, token) do
    [h|t] = String.split(token, ~r/-/, trim: true)
    |> Enum.map(&String.to_integer(&1))
    h..hd(t)
  end

  defp translate_token(:list, token) do
    String.split(token, ~r/,/, trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  defp translate_token(:num, token) do
    String.to_integer(token)
  end
  
end

defmodule InvalidNumberOfTokensError do
   defexception message: "Invalid number of cron tokens. Expected 5."
end

defmodule InvalidTokenError do
  defexception message: "Invalid token. Expected one of: num|*|num,num[...]|num-num"
end