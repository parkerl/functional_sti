defmodule Foo do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Foo.Repo, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Foo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule Foo.Repo do
  use Ecto.Repo, otp_app: :foo
end

defmodule Foo.TypedTable do
  use Ecto.Model
  schema "typed_table" do
    field :type, :string
    timestamps
  end

  def create_monkey do
    %Foo.TypedTable{type: "monkey"} |> Foo.Repo.insert!
  end

  def create_man_in_yellow_hat do
    %Foo.TypedTable{type: "man"} |> Foo.Repo.insert!
  end

  def all do
    Foo.TypedTable |> Foo.Repo.all
  end

  def say(%Foo.TypedTable{type: "monkey"} = record) do
    IO.puts "monkey say monkey do"
    IO.inspect record
  end

  def say(%Foo.TypedTable{type: "man"} = record) do
    IO.puts "george!!"
    IO.inspect record
  end

  def run_example do
    Foo.TypedTable.create_monkey
    Foo.TypedTable.create_man_in_yellow_hat
    Foo.TypedTable.all |> Enum.each  &Foo.TypedTable.say/1
  end
end

