--[[
  TreasureHunt_Plus_v1  protected build
  Loader: fetch parts -> xor -> lzss -> run
]]
local _8gzMPCC={
"https://raw.githubusercontent.com/fhuev12/TreasureHunt-Scripts/main/parts/TreasureHunt_Plus_v1.p1.txt",
"https://raw.githubusercontent.com/fhuev12/TreasureHunt-Scripts/main/parts/TreasureHunt_Plus_v1.p2.txt",
"https://raw.githubusercontent.com/fhuev12/TreasureHunt-Scripts/main/parts/TreasureHunt_Plus_v1.p3.txt"
}
local _9PpVmkb={}
for _sgARUX5=1,#_8gzMPCC do
  local _DPB38yz=game:HttpGet(_8gzMPCC[_sgARUX5])
  _9PpVmkb[#_9PpVmkb+1]=_DPB38yz
end
local _9mxpjzL=table.concat(_9PpVmkb):gsub('%s+','')
local _AqsJOpc='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local _4feWpJX={}
for _sgARUX5=1,#_AqsJOpc do _4feWpJX[_AqsJOpc:sub(_sgARUX5,_sgARUX5)]=_sgARUX5-1 end
local function _i3420a2(_YkicdgP)
  local _BpoLNC6={}
  local _sO763ib=#_YkicdgP
  local _sgARUX5=1
  while _sgARUX5<=_sO763ib do
    local _axTxUJT=_4feWpJX[_YkicdgP:sub(_sgARUX5,_sgARUX5)]
    local _nzQaM9l=_4feWpJX[_YkicdgP:sub(_sgARUX5+1,_sgARUX5+1)]
    local _DFiIK1t=_YkicdgP:sub(_sgARUX5+2,_sgARUX5+2)
    local _14G2A7d=_YkicdgP:sub(_sgARUX5+3,_sgARUX5+3)
    local _u7akcE5=(_DFiIK1t=='=') and -1 or _4feWpJX[_DFiIK1t]
    local _yZUMrJJ=(_14G2A7d=='=') and -1 or _4feWpJX[_14G2A7d]
    if not (_axTxUJT and _nzQaM9l) then break end
    _BpoLNC6[#_BpoLNC6+1]=string.char(_axTxUJT*4+math.floor(_nzQaM9l/16))
    if _u7akcE5 and _u7akcE5>=0 then
      _BpoLNC6[#_BpoLNC6+1]=string.char((_nzQaM9l%16)*16+math.floor(_u7akcE5/4))
      if _yZUMrJJ and _yZUMrJJ>=0 then
        _BpoLNC6[#_BpoLNC6+1]=string.char((_u7akcE5%4)*64+_yZUMrJJ)
      end
    end
    _sgARUX5=_sgARUX5+4
  end
  return table.concat(_BpoLNC6)
end
local _hCsOnlX='wcovrdqZls1uHKQmYxS0SPTT941D'
local _zBOJ36z=bit32
local function _2gSh1do(_YkicdgP)
  local _BpoLNC6={}
  local _S45HhAW=#_hCsOnlX
  for _sgARUX5=1,#_YkicdgP do
    _BpoLNC6[_sgARUX5]=string.char(_zBOJ36z.bxor(string.byte(_YkicdgP,_sgARUX5),string.byte(_hCsOnlX,(_sgARUX5-1)%_S45HhAW+1)))
  end
  return table.concat(_BpoLNC6)
end
local function _tyLV7RO(_YkicdgP)
  local _BpoLNC6={}
  local _sgARUX5=1
  local _dKqhf9o=0
  local _pmTVOS6=0
  while _sgARUX5<=#_YkicdgP do
    if _pmTVOS6==0 then _dKqhf9o=string.byte(_YkicdgP,_sgARUX5);_sgARUX5=_sgARUX5+1;_pmTVOS6=8 end
    if _zBOJ36z.band(_dKqhf9o,1)==1 then
      local _reRMlTO=string.byte(_YkicdgP,_sgARUX5)*256+string.byte(_YkicdgP,_sgARUX5+1)
      local _A3DNhmn=string.byte(_YkicdgP,_sgARUX5+2)
      _sgARUX5=_sgARUX5+3
      local _epiYU0U=#_BpoLNC6-_reRMlTO
      for _RFmJiUQ=1,_A3DNhmn do _BpoLNC6[#_BpoLNC6+1]=_BpoLNC6[_epiYU0U+_RFmJiUQ] end
    else
      _BpoLNC6[#_BpoLNC6+1]=string.sub(_YkicdgP,_sgARUX5,_sgARUX5)
      _sgARUX5=_sgARUX5+1
    end
    _dKqhf9o=_zBOJ36z.rshift(_dKqhf9o,1)
    _pmTVOS6=_pmTVOS6-1
  end
  return table.concat(_BpoLNC6)
end
local _1U68j5B=_2gSh1do(_i3420a2(_9mxpjzL))
local _A3DNhmn=_zBOJ36z.band(string.byte(_1U68j5B,1),255)+_zBOJ36z.lshift(_zBOJ36z.band(string.byte(_1U68j5B,2),255),8)+_zBOJ36z.lshift(_zBOJ36z.band(string.byte(_1U68j5B,3),255),16)+_zBOJ36z.lshift(_zBOJ36z.band(string.byte(_1U68j5B,4),255),24)
local _ygB3PS6=string.sub(_1U68j5B,5,4+_A3DNhmn)
local _MA1kBBT=_tyLV7RO(_ygB3PS6)
local _zGLB3PA=(loadstring or load)(_MA1kBBT,'@TreasureHunt_Plus_v1')
if not _zGLB3PA then error('protected payload failed to load') end
_zGLB3PA()
