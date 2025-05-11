defmodule HapesireWeb.Templates do
  @moduledoc false
  defmacro __using__(_options) do
    templates =
      with {:ok, files} <- File.ls(Hapesire.static()) do
        files
        |> Enum.filter(&(Path.extname(&1) == ".slime"))
        |> Enum.map(fn name ->
          template =
            "#{Hapesire.static()}/#{name}"
            |> File.read!()
            |> Slime.Renderer.precompile()

          formatted_name = String.to_atom("eval_#{Path.rootname(name)}")

          Macro.escape({name, formatted_name, template})
        end)
      end

    locales = Hapesire.locales()

    quote bind_quoted: [templates: templates, locales: locales] do
      for {name, formatted_name, template} <- templates do
        if formatted_name == :eval_root do
          defp __eval_root__(locale, internal_template, bindings) do
            EEx.eval_string(
              unquote(template),
              template: internal_template,
              current_locale: locale,
              locales: unquote(locales),
              bindings: [
                {:gettext, &HapesireWeb.gettext/2},
                {:bgettext, &HapesireWeb.gettext/3},
                {:dash, " — "},
                {:current_locale, locale} | bindings
              ]
            )
          end
        else
          @doc """
          Generated `#{name}` template evaluation function.
          """
          @spec unquote(formatted_name)(String.t(), Keyword.t()) :: String.t()
          def unquote(formatted_name)(locale, bindings) do
            __eval_root__(locale, unquote(template), bindings)
          end
        end
      end
    end
  end
end
