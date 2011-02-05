# encoding: utf-8

include Math

#
# A class to calcuate estimated implied volatilities for an option
#
#
class Ivolatility

  SQ2PI = Math.sqrt(2 * Math::PI)
  def IV(s, x, t, r, q, tt, p)

    e = 0.0001
    n = 13
    pLim = [0.005, 0.01 * p].min;

    v = Math.sqrt(   (Math.log(s/x) + (r-q)*t).abs   * 2 / t)

    if (v <= 0)
      v = 0.1
    end
    c = OptionPrice(s, x, t, v, r, q, tt)

    if ((p - c).abs < pLim)
      return v
    end

    vega = Vega(s, x, t, v, r, q)
    v1 = v - (c - p) / vega
    step = 1
    while ((v - v1).abs > e && step < n)

      v = v1
      c = OptionPrice(s, x, t, v, r, q, tt)
      if ((p - c).abs < pLim)
        return v
      end
      vega = Vega(s, x, t, v, r, q)
      v1 = v - (c - p) / vega
      if (v1 < 0)
        return v1
      end
      step= step + 1

    end

    if (step < n)
      return v1
    end
    c = OptionPrice(s, x, t, v1, r, q, tt)
    if ((p - c).abs < pLim)
      return v1
    else
      return -1
    end
  end

  # calculate vega
  def Vega(s, x, t, v, r, q)
    st = Math.sqrt(t)
    du = Math.log(s/x) + (r-q) * t
    p1 = s * Math.exp(-q * t)
    d1 = (du + v * v * t / 2) / (v * st)
    nd = Math.exp(-d1 * d1 / 2) / Math.sqrt(2 * Math::PI)
    return p1 * st * nd
  end

  # This gives an approxination of the Implied volatility
  def OptionPrice(s, x, t, v, r, q, tt)

    st = Math.sqrt(t)
    du = Math.log(s/x) + (r-q) * t
    p1 = s * Math.exp(-q * t)
    x1 = x * Math.exp(-r * t)
    d1 = (du + v * v * t / 2) / (v * st)
    d2 = d1 - v * st

    if (tt == 0)

      return p1 * NormDist(d1) - x1 * NormDist(d2)
    else

      return x1 * NormDist(-d2) - p1 * NormDist(-d1)
    end
  end

  def NormDist(x)

    p  =  0.2316419
    b1 =  0.319381530
    b2 = -0.356563782
    b3 =  1.781477937
    b4 = -1.821255978
    b5 =  1.330274429

    y = x.abs
    z = Math.exp(-y*y/2) / Math.sqrt(2 * Math::PI)
    t = 1 / ( 1 + p * y)
    cum = 1 - z * (b1*t + b2*t*t + b3*t*t*t + b4*t*t*t*t + b5*t*t*t*t*t)

    if (x < 0)
      cum = 1 - cum
    end

    return cum

  end

  def expireTime(time)
    time2 = Float(time) + Float(1)
    time3 = time2/Float(365)
    return  time3
  end

  # main end
end
