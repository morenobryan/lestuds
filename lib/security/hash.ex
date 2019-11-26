defmodule Security.Hash do
  @moduledoc """
  This module collects all hash-related functions for this application
  """

  @doc """
  Generates a hash of a string based on the SHA-256 algorithm
  """
  def digest(plain) when is_binary(plain) do
    :crypto.hash(:sha256, plain) |> Base.encode16()
  end

  def digest(_), do: nil
end
