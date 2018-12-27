defmodule ResamplexTest do
  use ExUnit.Case
  doctest Resamplex

  test "resamples jpg fine" do
    {:ok, file_path} = Resamplex.request("test/jobs.jpg", 30, 20)
    file = File.read!(file_path)
    expected_file = File.read!("test/tinyjobs.jpg")
    assert file == expected_file
  end

  test "resamples png fine" do
    {:ok, file_path} = Resamplex.request("test/john.png", 20, 30)
    file = File.read!(file_path)
    expected_file = File.read!("test/tinyjohn.jpg")
    assert file == expected_file
  end
end
