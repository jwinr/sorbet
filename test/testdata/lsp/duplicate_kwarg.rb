# typed: true

def foo(x:, x: nil)
          # ^^^^^^ error: duplicate argument name x
end

def bar(x, y:, y: nil)
             # ^^^^^^ error: duplicate argument name y
end