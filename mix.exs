defmodule Resamplex.MixProject do
  use Mix.Project

  def project do
    [
      app: :resamplex,
      version: "0.1.0",
      elixir: "~> 1.7",
      compilers: [:elixir_make] ++ Mix.compilers,
      aliases: [clean: ["clean", "clean.make"]],
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Resamplex",
      source_url: "https://github.com/pmarreck/resamplex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Resamplex, []},
      extra_applications: [:logger, :erlexec, :exexec, :poolboy],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exexec, "~> 0.1"},
      {:poolboy, "~> 1.5"},
      {:elixir_make, "~> 0.4", runtime: false}
    ]
  end

  defp description() do
    "Resamplex is a supervised image resizer that is based on evadne/supervised-scaler and depends on libvips. NOTE: Absolutely NO use of ImageMagick or GraphicsMagick!"
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src c_src/*.c Makefile),
      licenses: ["Apache 2.0"],
      maintainers: ["Peter Marreck"],
      links: %{"GitHub" => "https://github.com/pmarreck/resamplex"}
    ]
  end
end
